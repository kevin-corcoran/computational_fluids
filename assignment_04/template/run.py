import subprocess

""" make clean """
subprocess.run(["make", "clean"], capture_output=True, encoding="utf-8", text=True)
# subprocess.run([
#     "gnome-terminal",
#     "-e", f"\\make clean"
#     ])

""" Write to slug.init """
filename = "slug.init"
sim_riemann = 'roe'
sim_order = (3,'ppm')
sim_limiter = ('mm','minmod') #mc #vanLeer #minmod"

sim_name = 'sod128_'+sim_order[1]+'_'+sim_limiter[0]+'_'+sim_riemann

lines = [
    r"# Please put your runtime parameters: ",
    r"# name, and a space, followed by values ",
    "\n",
    r"# sim variables",
    f"sim_name \'{sim_name}\'",
    r"sim_cfl 0.8 ",
    r"sim_tmax 0.15 # 0.15 # 0.2",
    r"sim_nStep 100000",
    f"sim_riemann \'{sim_riemann}\' #roe #hll",
    f"sim_limiter \'{sim_limiter[1]}\'",
    r"sim_charLimiting .false.",
    f"sim_order {sim_order[0]}",
    "\n",
    r"# grid variables",
    r"gr_nx 128",
    r"gr_ngc 2",
    r"gr_xbeg 0.0",
    r"gr_xend 1.0",
    "\n",
    r"# problem specific physical IC",
    r"sim_shockLoc 0.5",
    r"sim_densL 1.0",
    r"sim_velxL 0.0 #0.#-2.",
    r"sim_presL 1.0 #1.0 #0.4",
    r"sim_densR 0.125 #0.125 #1.0",
    r"sim_velxR 0.0 #0. #2.0",
    r"sim_presR 0.1 #0.1 #0.4",
    r"sim_gamma 1.4",
    r"sim_smallPres 1.e-12",
    "\n",
    r"# BC type",
    r"sim_bcType 'outflow'",
    "\n",
    r"# IO frequency",
    r"sim_ioTfreq 0.01 #real",
    r"sim_ioNfreq 10    #positive integer; zero or negative if not used"
]

# write to file
with open(filename,"w") as f:
    f.write("\n".join(lines))


""" make """
subprocess.run(["make"], capture_output=True, encoding="utf-8", text=True)


""" Run ./slugEuler1d """
p = subprocess.run([
        r"./slugEuler1d"
    ], capture_output=True, encoding="utf-8", text=True)
print(p.stdout)

# get number of iterations
out = p.stdout.split("\n")[-6]
import re
match = re.search(r'[0-9]+', out).group()
num_iter = int(match) + 10000


""" Write to plotter.m """
filename = "plotter_.m"
last_dat_file = "slug_"+sim_name+'_'+str(num_iter)+'.dat'
print(last_dat_file)
title = sim_name.replace("_"," ")
lines = [
        "close all;",
        "clear all;",
        "clf;",
        f"foghll=dlmread(\'{last_dat_file}\');",
        "figure(1);",
        "hold on;",
        f"title(\'{title}\')",
        "plot(foghll(:,1),foghll(:,2),'r');"
]
# # write to file
# with open(filename,"w") as f:
#     f.write("\n".join(lines))


""" Run plotter.m """
# subprocess.run([
#         "matlab", 
#         "-nodesktop",
#         "-nosplash",
#         "-r",
#         f"\"{filename.split('.')[0]}\""
#     ])
# matlab -nodesktop -nosplash -r "plotter"

def run(file_name):
    subprocess.Popen([
        "gnome-terminal",
        "-e", f"\\matlab -nodesktop -nosplash -r \"{file_name.split('.')[0]}\""
        ])


# Menu
while False:
    sel = input("E: edit, P: plot, Q: quit\n").upper()

    filename = input("Type: plotter\n")
    # while not os.path.isfile(filename):
    #     print("not a file")
    #     filename = input("Input file for editing\n")

    if sel == "E":
        pass
    elif sel == "R":
        run(filename)
        pass
    elif sel == "Q":
        print("Goodbye!")
        break
