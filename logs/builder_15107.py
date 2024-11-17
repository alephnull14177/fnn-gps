# 2024-11-01T16:31:09.941768
import vitis

client = vitis.create_client()
client.set_workspace(path="/ecel/UFAD/mark.gross/fnn-gps")

comp = client.create_hls_component(name="gps-parser", cfg_file = ["hls_config.cfg"], template = "empty_hls_component")

vitis.dispose()

