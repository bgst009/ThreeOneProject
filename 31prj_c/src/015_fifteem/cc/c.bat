@echo off

tcc -c %1
tlink c0s main %1,%1,,cs.lib