{
  description = "A Nix flake to use poetry";


  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux = let
      pkgs = import nixpkgs {
         system = "x86_64-linux";
         config = {
           allowUnfree = true;
           # cudaSupport = true;
           # cudaVersion = "12.6"; # Some packages like nix's torch respect this, others not... I'm not sure about the version number format.
         };
      };
    in pkgs.mkShell {
      buildInputs = with pkgs; [
        python312 # nix' python
        
        jq

        poetry # <- Uses Nix's system default python by default
      ];

      shellHook = ''
          # Pass the libraries (to poetry's virtual environment for using Python packages)
          DOT_ENV="$WORKSPACE_FOLDER/.env" # File as specified by VSCode Python for storing environment variables

          # For poetry
          echo "LD_LIBRARY_PATH=\"${pkgs.gcc.cc.lib}/lib:$LD_LIBRARY_PATH\"" >> "$DOT_ENV"

          # Export variables
          set -a # auto-export
          source "$DOT_ENV" # Export variables needed for the project
          set +a

          # Create virtual environment
          poetry config virtualenvs.create false # Disable poetry's own virtual environment management
          python -m venv ~/venv
          source ~/venv/bin/activate

          # Pass the virtual environment to poetry
          poetry env use $(which python)
          
          // Ollama
          export OLLAMA_HOST=http://host.containers.internal:11434

          poetry install --no-root
        '';

    };
  };
  
}

