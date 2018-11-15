import cProfile
import pstats
from io import StringIO
import LV1

pr = cProfile.Profile()


pr.enable()
LV1.main([])
pr.disable()

s = StringIO()
ps = pstats.Stats(pr, stream=s)
ps.print_stats(0).sort_stats("calls") #sort by calls

print("Profiling LV1.py:")
print(s.getvalue())
