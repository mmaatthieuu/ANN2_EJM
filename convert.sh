#!/bin/bash

for f in `ls ./plots/*/*.eps`; do
     convert -density 200 $f -flatten ${f%.*}.png;
done 


