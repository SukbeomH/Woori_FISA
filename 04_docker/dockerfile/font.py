import matplotlib.pyplot as plt
import matplotlib as mpl
from matplotlib import rc, font_manager

font_fname = "/usr/share/fonts/truetype/nanum/NanumGothic.ttf"
prop = font_manager.FontProperties(fname=font_fname)
mpl.rcParams["font.family"] = "NanumGothic"
mpl.rcParams["axes.unicode_minus"] = False

font_list = font_manager.findSystemFonts(fontpaths=None, fontext="ttf")
font_list
