#!/usr/bin/perl

print qx(perl -MDevel::Cover tests/*);
print qx(cover);
print qx(cover -delete);
