# How to rebuild the Backend

Access hadez or hades through ssh.

Consider the following if you want to update the backend after modifying `/opt/Carme/Carme-Backend/Python/carme_backend/server.py`. 


- Delete all files in `/opt/Carme/Carme-Backend` except:
  - `setup.py`
  - `bin/carme-backend`
  - `carme_backend/server.py`
  - `carme_backend/__init__.py`.


- `source /opt/mamba/etc/profile.d/conda.sh`
- `source /opt/mamba/etc/profile.d/mamba.sh`
- `mamba activate carme-backend-build`
- `python setup.py bdist_wheel` (build the wheel)
- `mamba deactivate`
- `mamba activate carme-backend`
- `pip install --force-reinstall /opt/Carme/Carme-Backend/Python/dist/carme_backend*.whl` (force reinstalling the wheel)
- `mamba deactivate`
- `systemctl restart carme-backend` 
