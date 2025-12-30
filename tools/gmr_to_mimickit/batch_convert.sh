#!/bin/bash

# 配置路径
INPUT_FOLDER="/home/yk/Desktop/GMR/robot_retargeted_data/box_data/Punching"
OUTPUT_FOLDER="/home/yk/Desktop/MimicKit/data/motions/hand"
SCRIPT_PATH="/home/yk/Desktop/MimicKit/tools/gmr_to_mimickit/gmr_to_mimickit.py"

# 激活mimickit环境
conda activate mimickit

# 进入MimicKit根目录（必须！）
cd /home/yk/Desktop/MimicKit

# 创建输出文件夹（若不存在）
mkdir -p ${OUTPUT_FOLDER}

# 遍历所有GMR pkl文件并转换
for input_file in ${INPUT_FOLDER}/*.pkl; do
    # 提取文件名（不含路径）
    filename=$(basename ${input_file})
    # 拼接输出路径
    output_file="${OUTPUT_FOLDER}/${filename}"
    
    # 执行转换脚本
    echo "========================================"
    echo "转换文件: ${input_file}"
    echo "输出文件: ${output_file}"
    echo "========================================"
    python ${SCRIPT_PATH} \
      --input_file ${input_file} \
      --output_file ${output_file} \
      --loop wrap \
      --start_frame 0 \
      --end_frame -1 \
      --output_fps 200
    
    # 检查转换是否成功
    if [ $? -eq 0 ]; then
        echo "✅ ${filename} 转换成功！"
    else
        echo "❌ ${filename} 转换失败！"
    fi
done

echo "========================================"
echo "批量转换完成！所有文件已保存到: ${OUTPUT_FOLDER}"
echo "========================================"
