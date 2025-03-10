import os
import matplotlib.pyplot as plt

def split_and_visualize_cli(file_path, axis='Y', threshold=0):
    """
    Splits a CLI file into two parts and visualizes them.

    :param file_path: Path to the input CLI file.
    :param axis: 'X' or 'Y' - Axis along which to split the toolpath.
    :param threshold: Coordinate value to divide the file.
    """
    with open(file_path, "r") as f:
        lines = f.readlines()

    part1_lines = []
    part2_lines = []
    part1_coords = []
    part2_coords = []
    current_polyline = []

    is_inside_polyline = False

    for line in lines:
        stripped = line.strip()

        if stripped.startswith("$$LAYER"):  
            if current_polyline:
                # Save the previous polyline
                if part1_coords:
                    part1_lines.extend(current_polyline)
                if part2_coords:
                    part2_lines.extend(current_polyline)
                current_polyline = []

            part1_lines.append(line)
            part2_lines.append(line)

        elif stripped.startswith("$$POLYLINE"):  
            is_inside_polyline = True
            current_polyline = [line]
            polyline_coords = []

        elif stripped.startswith("$$ENDPOLYLINE"):  
            is_inside_polyline = False

            # Split the polyline into two parts
            if any(y < threshold for _, y in polyline_coords):
                part1_coords.append(polyline_coords)
                part1_lines.extend(current_polyline)
            if any(y >= threshold for _, y in polyline_coords):
                part2_coords.append(polyline_coords)
                part2_lines.extend(current_polyline)

            current_polyline.append(line)

        elif is_inside_polyline:
            coords = list(map(float, stripped.split()))
            x, y = coords[:2]  

            if axis.upper() == "X":
                coord_value = x
            else:
                coord_value = y

            polyline_coords.append((x, y))
            current_polyline.append(line)

        else:
            part1_lines.append(line)
            part2_lines.append(line)

    # Save split CLI files
    base_name, ext = os.path.splitext(file_path)
    with open(f"{base_name}_part1.cli", "w") as f1:
        f1.writelines(part1_lines)
    with open(f"{base_name}_part2.cli", "w") as f2:
        f2.writelines(part2_lines)

    # Plot the split CLI files
    plt.figure(figsize=(8, 6))
    for polyline in part1_coords:
        plt.plot(*zip(*polyline), 'bo-', label="Laser 1" if 'Laser 1' not in plt.gca().get_legend_handles_labels()[1] else "")
    for polyline in part2_coords:
        plt.plot(*zip(*polyline), 'ro-', label="Laser 2" if 'Laser 2' not in plt.gca().get_legend_handles_labels()[1] else "")

    plt.axhline(y=threshold, color='k', linestyle='--', label="Split Line" if axis.upper() == "Y" else "")
    plt.axvline(x=threshold, color='k', linestyle='--', label="Split Line" if axis.upper() == "X" else "")
    plt.xlabel("X Coordinate")
    plt.ylabel("Y Coordinate")
    plt.title("Visualization of CLI File Split for Dual Laser System")
    plt.legend()
    plt.grid(True)
    plt.show()

    print(f"CLI file split complete: {base_name}_part1.cli and {base_name}_part2.cli generated.")

# Example usage
split_and_visualize_cli("20mm_cube(repaired)(filling).cli", axis='X', threshold=0)
