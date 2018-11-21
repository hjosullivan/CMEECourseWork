import cProfile
import pstats
from io import StringIO
import LV1
import LV2

#profile LV1
pr = cProfile.Profile()

pr.enable()
LV1.main([])
pr.disable()

s = StringIO()
ps = pstats.Stats(pr, stream=s)
ps.print_stats(0).sort_stats("calls") #sort by calls

print("Profiling LV1.py:")
print(s.getvalue())

#profile LV2
pr2 = cProfile.Profile()

pr2.enable()
LV2.main([])
pr2.disable()

s2 = StringIO()
ps2 = pstats.Stats(pr2, stream=s2)
ps2.print_stats(0).sort_stats("calls") #sort by calls

print("Profiling LV1.py:")
print(s2.getvalue())
