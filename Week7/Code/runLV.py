#!/usr/bin/env python3
"""

Profiling Lokta-Volterra python scripts

"""
__author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
__appname__ = "runLV"
__version__ = "0.0.1"
__license__ = "I do not have one"

# Import modules
import cProfile
import pstats
from io import StringIO
import LV1
import LV2
import LV3
import LV4

# Profile LV1
pr = cProfile.Profile()

pr.enable()
LV1.main([])
pr.disable()

s = StringIO()
ps = pstats.Stats(pr, stream=s)
ps.print_stats(0).sort_stats("calls") # Sort by calls

print("Profiling LV1.py:")
print(s.getvalue())

# Profile LV2
pr = cProfile.Profile()

pr.enable()
LV2.main([])
pr.disable()

s = StringIO()
ps = pstats.Stats(pr, stream=s)
ps.print_stats(0).sort_stats("calls") # Sort by calls

print("Profiling LV2.py:")
print(s.getvalue())

# Profile LV3
pr = cProfile.Profile()

pr.enable()
LV3.main([])
pr.disable()

s = StringIO()
ps = pstats.Stats(pr, stream=s)
ps.print_stats(0).sort_stats("calls") # Sort by calls

print("Profiling LV3.py:")
print(s.getvalue())
