# 复现笔记
## 配置
方式和readme类似
```sh
conda create -n diffusion_planner python=3.9
conda activate diffusion_planner
pip install "pip<24.1"
git clone https://github.com/motional/nuplan-devkit.git && cd nuplan-devkit
pip install -e .
pip install -r requirements.txt
cd ..
git clone https://github.com/ZhengYinan-AIR/Diffusion-Planner.git && cd Diffusion-Planner
pip install -e .
pip install -r requirements_torch.txt
mkdir -p checkpoints
wget -P ./checkpoints https://huggingface.co/ZhengYinan2001/Diffusion-Planner/resolve/main/args.json
wget -P ./checkpoints https://huggingface.co/ZhengYinan2001/Diffusion-Planner/resolve/main/model.pth
bash sim_diffusion_planner_runner.sh
```
Run the simulation
1. Set up configuration in sim_diffusion_planner_runner.sh.
2. Run `bash sim_diffusion_planner_runner.sh`
Visualize the results
1. Set up configuration in run_nuboard.ipynb.
2. Launch Jupyter Notebook or JupyterLab to execute run_nuboard.ipynb.
