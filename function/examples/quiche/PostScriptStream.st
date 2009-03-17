" PostScriptStream.st -- PostScript device driver

  Copyright (c) 2009 Ian Piumarta
  All rights reserved.

  Permission is hereby granted, free of charge, to any person obtaining a
  copy of this software and associated documentation files (the 'Software'),
  to deal in the Software without restriction, including without limitation
  the rights to use, copy, modify, merge, publish, distribute, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, provided that the above copyright notice(s) and this
  permission notice appear in all copies of the Software and that both the
  above copyright notice(s) and this permission notice appear in supporting
  documentation.

  THE SOFTWARE IS PROVIDED 'AS IS'.  USE ENTIRELY AT YOUR OWN RISK.

  Last edited: 2009-03-16 20:28:29 by piumarta on emilia
"

{ import: Stream }

UnicodeToPostScriptStandardMap := [
    #(	(0x0020	0x20)	"# SPACE	# space"
	(0x00A0	0x20)	"# NO-BREAK SPACE	# space"
	(0x0021	0x21)	"# EXCLAMATION MARK	# exclam"
	(0x0022	0x22)	"# QUOTATION MARK	# quotedbl"
	(0x0023	0x23)	"# NUMBER SIGN	# numbersign"
	(0x0024	0x24)	"# DOLLAR SIGN	# dollar"
	(0x0025	0x25)	"# PERCENT SIGN	# percent"
	(0x0026	0x26)	"# AMPERSAND	# ampersand"
	(0x2019	0x27)	"# RIGHT SINGLE QUOTATION MARK	# quoteright"
	(0x0028	0x28)	"# LEFT PARENTHESIS	# parenleft"
	(0x0029	0x29)	"# RIGHT PARENTHESIS	# parenright"
	(0x002A	0x2A)	"# ASTERISK	# asterisk"
	(0x002B	0x2B)	"# PLUS SIGN	# plus"
	(0x002C	0x2C)	"# COMMA	# comma"
	(0x002D	0x2D)	"# HYPHEN-MINUS	# hyphen"
	(0x00AD	0x2D)	"# SOFT HYPHEN	# hyphen"
	(0x002E	0x2E)	"# FULL STOP	# period"
	(0x002F	0x2F)	"# SOLIDUS	# slash"
	(0x0030	0x30)	"# DIGIT ZERO	# zero"
	(0x0031	0x31)	"# DIGIT ONE	# one"
	(0x0032	0x32)	"# DIGIT TWO	# two"
	(0x0033	0x33)	"# DIGIT THREE	# three"
	(0x0034	0x34)	"# DIGIT FOUR	# four"
	(0x0035	0x35)	"# DIGIT FIVE	# five"
	(0x0036	0x36)	"# DIGIT SIX	# six"
	(0x0037	0x37)	"# DIGIT SEVEN	# seven"
	(0x0038	0x38)	"# DIGIT EIGHT	# eight"
	(0x0039	0x39)	"# DIGIT NINE	# nine"
	(0x003A	0x3A)	"# COLON	# colon"
	(0x003B	0x3B)	"# SEMICOLON	# semicolon"
	(0x003C	0x3C)	"# LESS-THAN SIGN	# less"
	(0x003D	0x3D)	"# EQUALS SIGN	# equal"
	(0x003E	0x3E)	"# GREATER-THAN SIGN	# greater"
	(0x003F	0x3F)	"# QUESTION MARK	# question"
	(0x0040	0x40)	"# COMMERCIAL AT	# at"
	(0x0041	0x41)	"# LATIN CAPITAL LETTER A	# A"
	(0x0042	0x42)	"# LATIN CAPITAL LETTER B	# B"
	(0x0043	0x43)	"# LATIN CAPITAL LETTER C	# C"
	(0x0044	0x44)	"# LATIN CAPITAL LETTER D	# D"
	(0x0045	0x45)	"# LATIN CAPITAL LETTER E	# E"
	(0x0046	0x46)	"# LATIN CAPITAL LETTER F	# F"
	(0x0047	0x47)	"# LATIN CAPITAL LETTER G	# G"
	(0x0048	0x48)	"# LATIN CAPITAL LETTER H	# H"
	(0x0049	0x49)	"# LATIN CAPITAL LETTER I	# I"
	(0x004A	0x4A)	"# LATIN CAPITAL LETTER J	# J"
	(0x004B	0x4B)	"# LATIN CAPITAL LETTER K	# K"
	(0x004C	0x4C)	"# LATIN CAPITAL LETTER L	# L"
	(0x004D	0x4D)	"# LATIN CAPITAL LETTER M	# M"
	(0x004E	0x4E)	"# LATIN CAPITAL LETTER N	# N"
	(0x004F	0x4F)	"# LATIN CAPITAL LETTER O	# O"
	(0x0050	0x50)	"# LATIN CAPITAL LETTER P	# P"
	(0x0051	0x51)	"# LATIN CAPITAL LETTER Q	# Q"
	(0x0052	0x52)	"# LATIN CAPITAL LETTER R	# R"
	(0x0053	0x53)	"# LATIN CAPITAL LETTER S	# S"
	(0x0054	0x54)	"# LATIN CAPITAL LETTER T	# T"
	(0x0055	0x55)	"# LATIN CAPITAL LETTER U	# U"
	(0x0056	0x56)	"# LATIN CAPITAL LETTER V	# V"
	(0x0057	0x57)	"# LATIN CAPITAL LETTER W	# W"
	(0x0058	0x58)	"# LATIN CAPITAL LETTER X	# X"
	(0x0059	0x59)	"# LATIN CAPITAL LETTER Y	# Y"
	(0x005A	0x5A)	"# LATIN CAPITAL LETTER Z	# Z"
	(0x005B	0x5B)	"# LEFT SQUARE BRACKET	# bracketleft"
	(0x005C	0x5C)	"# REVERSE SOLIDUS	# backslash"
	(0x005D	0x5D)	"# RIGHT SQUARE BRACKET	# bracketright"
	(0x005E	0x5E)	"# CIRCUMFLEX ACCENT	# asciicircum"
	(0x005F	0x5F)	"# LOW LINE	# underscore"
	(0x2018	0x60)	"# LEFT SINGLE QUOTATION MARK	# quoteleft"
	(0x0061	0x61)	"# LATIN SMALL LETTER A	# a"
	(0x0062	0x62)	"# LATIN SMALL LETTER B	# b"
	(0x0063	0x63)	"# LATIN SMALL LETTER C	# c"
	(0x0064	0x64)	"# LATIN SMALL LETTER D	# d"
	(0x0065	0x65)	"# LATIN SMALL LETTER E	# e"
	(0x0066	0x66)	"# LATIN SMALL LETTER F	# f"
	(0x0067	0x67)	"# LATIN SMALL LETTER G	# g"
	(0x0068	0x68)	"# LATIN SMALL LETTER H	# h"
	(0x0069	0x69)	"# LATIN SMALL LETTER I	# i"
	(0x006A	0x6A)	"# LATIN SMALL LETTER J	# j"
	(0x006B	0x6B)	"# LATIN SMALL LETTER K	# k"
	(0x006C	0x6C)	"# LATIN SMALL LETTER L	# l"
	(0x006D	0x6D)	"# LATIN SMALL LETTER M	# m"
	(0x006E	0x6E)	"# LATIN SMALL LETTER N	# n"
	(0x006F	0x6F)	"# LATIN SMALL LETTER O	# o"
	(0x0070	0x70)	"# LATIN SMALL LETTER P	# p"
	(0x0071	0x71)	"# LATIN SMALL LETTER Q	# q"
	(0x0072	0x72)	"# LATIN SMALL LETTER R	# r"
	(0x0073	0x73)	"# LATIN SMALL LETTER S	# s"
	(0x0074	0x74)	"# LATIN SMALL LETTER T	# t"
	(0x0075	0x75)	"# LATIN SMALL LETTER U	# u"
	(0x0076	0x76)	"# LATIN SMALL LETTER V	# v"
	(0x0077	0x77)	"# LATIN SMALL LETTER W	# w"
	(0x0078	0x78)	"# LATIN SMALL LETTER X	# x"
	(0x0079	0x79)	"# LATIN SMALL LETTER Y	# y"
	(0x007A	0x7A)	"# LATIN SMALL LETTER Z	# z"
	(0x007B	0x7B)	"# LEFT CURLY BRACKET	# braceleft"
	(0x007C	0x7C)	"# VERTICAL LINE	# bar"
	(0x007D	0x7D)	"# RIGHT CURLY BRACKET	# braceright"
	(0x007E	0x7E)	"# TILDE	# asciitilde"
	(0x00A1	0xA1)	"# INVERTED EXCLAMATION MARK	# exclamdown"
	(0x00A2	0xA2)	"# CENT SIGN	# cent"
	(0x00A3	0xA3)	"# POUND SIGN	# sterling"
	(0x2044	0xA4)	"# FRACTION SLASH	# fraction"
	(0x2215	0xA4)	"# DIVISION SLASH	# fraction"
	(0x00A5	0xA5)	"# YEN SIGN	# yen"
	(0x0192	0xA6)	"# LATIN SMALL LETTER F WITH HOOK	# florin"
	(0x00A7	0xA7)	"# SECTION SIGN	# section"
	(0x00A4	0xA8)	"# CURRENCY SIGN	# currency"
	(0x0027	0xA9)	"# APOSTROPHE	# quotesingle"
	(0x201C	0xAA)	"# LEFT DOUBLE QUOTATION MARK	# quotedblleft"
	(0x00AB	0xAB)	"# LEFT-POINTING DOUBLE ANGLE QUOTATION MARK	# guillemotleft"
	(0x2039	0xAC)	"# SINGLE LEFT-POINTING ANGLE QUOTATION MARK	# guilsinglleft"
	(0x203A	0xAD)	"# SINGLE RIGHT-POINTING ANGLE QUOTATION MARK	# guilsinglright"
	(0xFB01	0xAE)	"# LATIN SMALL LIGATURE FI	# fi"
	(0xFB02	0xAF)	"# LATIN SMALL LIGATURE FL	# fl"
	(0x2013	0xB1)	"# EN DASH	# endash"
	(0x2020	0xB2)	"# DAGGER	# dagger"
	(0x2021	0xB3)	"# DOUBLE DAGGER	# daggerdbl"
	(0x00B7	0xB4)	"# MIDDLE DOT	# periodcentered"
	(0x2219	0xB4)	"# BULLET OPERATOR	# periodcentered"
	(0x00B6	0xB6)	"# PILCROW SIGN	# paragraph"
	(0x2022	0xB7)	"# BULLET	# bullet"
	(0x201A	0xB8)	"# SINGLE LOW-9 QUOTATION MARK	# quotesinglbase"
	(0x201E	0xB9)	"# DOUBLE LOW-9 QUOTATION MARK	# quotedblbase"
	(0x201D	0xBA)	"# RIGHT DOUBLE QUOTATION MARK	# quotedblright"
	(0x00BB	0xBB)	"# RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK	# guillemotright"
	(0x2026	0xBC)	"# HORIZONTAL ELLIPSIS	# ellipsis"
	(0x2030	0xBD)	"# PER MILLE SIGN	# perthousand"
	(0x00BF	0xBF)	"# INVERTED QUESTION MARK	# questiondown"
	(0x0060	0xC1)	"# GRAVE ACCENT	# grave"
	(0x00B4	0xC2)	"# ACUTE ACCENT	# acute"
	(0x02C6	0xC3)	"# MODIFIER LETTER CIRCUMFLEX ACCENT	# circumflex"
	(0x02DC	0xC4)	"# SMALL TILDE	# tilde"
	(0x00AF	0xC5)	"# MACRON	# macron"
	(0x02C9	0xC5)	"# MODIFIER LETTER MACRON	# macron"
	(0x02D8	0xC6)	"# BREVE	# breve"
	(0x02D9	0xC7)	"# DOT ABOVE	# dotaccent"
	(0x00A8	0xC8)	"# DIAERESIS	# dieresis"
	(0x02DA	0xCA)	"# RING ABOVE	# ring"
	(0x00B8	0xCB)	"# CEDILLA	# cedilla"
	(0x02DD	0xCD)	"# DOUBLE ACUTE ACCENT	# hungarumlaut"
	(0x02DB	0xCE)	"# OGONEK	# ogonek"
	(0x02C7	0xCF)	"# CARON	# caron"
	(0x2014	0xD0)	"# EM DASH	# emdash"
	(0x00C6	0xE1)	"# LATIN CAPITAL LETTER AE	# AE"
	(0x00AA	0xE3)	"# FEMININE ORDINAL INDICATOR	# ordfeminine"
	(0x0141	0xE8)	"# LATIN CAPITAL LETTER L WITH STROKE	# Lslash"
	(0x00D8	0xE9)	"# LATIN CAPITAL LETTER O WITH STROKE	# Oslash"
	(0x0152	0xEA)	"# LATIN CAPITAL LIGATURE OE	# OE"
	(0x00BA	0xEB)	"# MASCULINE ORDINAL INDICATOR	# ordmasculine"
	(0x00E6	0xF1)	"# LATIN SMALL LETTER AE	# ae"
	(0x0131	0xF5)	"# LATIN SMALL LETTER DOTLESS I	# dotlessi"
	(0x0142	0xF8)	"# LATIN SMALL LETTER L WITH STROKE	# lslash"
	(0x00F8	0xF9)	"# LATIN SMALL LETTER O WITH STROKE	# oslash"
	(0x0153	0xFA)	"# LATIN SMALL LIGATURE OE	# oe"
	(0x00DF	0xFB)	"# LATIN SMALL LETTER SHARP S	# germandbls"
    ) inject: IdentityDictionary new into: [:map :unipss | map at: unipss first put: unipss second; yourself]
]

UnicodeToPostScriptSymbolMap := [
    #(	(0x0020 0x20)	"SPACE"
	(0x0021 0x21)	"EXCLAMATION MARK"
	(0x2200 0x22)	"FOR ALL"
	(0x0023 0x23)	"NUMBER SIGN"
	(0x2203 0x24)	"THERE EXISTS"
	(0x0025 0x25)	"PERCENT SIGN"
	(0x0026 0x26)	"AMPERSAND"
	(0x220D 0x27)	"SMALL CONTAINS AS MEMBER"
	(0x0028 0x28)	"LEFT PARENTHESIS"
	(0x0029 0x29)	"RIGHT PARENTHESIS"
	(0x2217 0x2A)	"ASTERISK OPERATOR"
	(0x002B 0x2B)	"PLUS SIGN"
	(0x002C 0x2C)	"COMMA"
	(0x2212 0x2D)	"MINUS SIGN"
	(0x002E 0x2E)	"FULL STOP"
	(0x002F 0x2F)	"SOLIDUS"
	(0x0030 0x30)	"DIGIT ZERO"
	(0x0031 0x31)	"DIGIT ONE"
	(0x0032 0x32)	"DIGIT TWO"
	(0x0033 0x33)	"DIGIT THREE"
	(0x0034 0x34)	"DIGIT FOUR"
	(0x0035 0x35)	"DIGIT FIVE"
	(0x0036 0x36)	"DIGIT SIX"
	(0x0037 0x37)	"DIGIT SEVEN"
	(0x0038 0x38)	"DIGIT EIGHT"
	(0x0039 0x39)	"DIGIT NINE"
	(0x003A 0x3A)	"COLON"
	(0x003B 0x3B)	"SEMICOLON"
	(0x003C 0x3C)	"LESS-THAN SIGN"
	(0x003D 0x3D)	"EQUALS SIGN"
	(0x003E 0x3E)	"GREATER-THAN SIGN"
	(0x003F 0x3F)	"QUESTION MARK"
	(0x2245 0x40)	"APPROXIMATELY EQUAL TO"
	(0x0391 0x41)	"GREEK CAPITAL LETTER ALPHA"
	(0x0392 0x42)	"GREEK CAPITAL LETTER BETA"
	(0x03A7 0x43)	"GREEK CAPITAL LETTER CHI"
	(0x0394 0x44)	"GREEK CAPITAL LETTER DELTA"
	(0x0395 0x45)	"GREEK CAPITAL LETTER EPSILON"
	(0x03A6 0x46)	"GREEK CAPITAL LETTER PHI"
	(0x0393 0x47)	"GREEK CAPITAL LETTER GAMMA"
	(0x0397 0x48)	"GREEK CAPITAL LETTER ETA"
	(0x0399 0x49)	"GREEK CAPITAL LETTER IOTA"
	(0x03D1 0x4A)	"GREEK THETA SYMBOL"
	(0x039A 0x4B)	"GREEK CAPITAL LETTER KAPPA"
	(0x039B 0x4C)	"GREEK CAPITAL LETTER LAMDA"
	(0x039C 0x4D)	"GREEK CAPITAL LETTER MU"
	(0x039D 0x4E)	"GREEK CAPITAL LETTER NU"
	(0x039F 0x4F)	"GREEK CAPITAL LETTER OMICRON"
	(0x03A0 0x50)	"GREEK CAPITAL LETTER PI"
	(0x0398 0x51)	"GREEK CAPITAL LETTER THETA"
	(0x03A1 0x52)	"GREEK CAPITAL LETTER RHO"
	(0x03A3 0x53)	"GREEK CAPITAL LETTER SIGMA"
	(0x03A4 0x54)	"GREEK CAPITAL LETTER TAU"
	(0x03A5 0x55)	"GREEK CAPITAL LETTER UPSILON"
	(0x03C2 0x56)	"GREEK SMALL LETTER FINAL SIGMA"
	(0x03A9 0x57)	"GREEK CAPITAL LETTER OMEGA"
	(0x039E 0x58)	"GREEK CAPITAL LETTER XI"
	(0x03A8 0x59)	"GREEK CAPITAL LETTER PSI"
	(0x0396 0x5A)	"GREEK CAPITAL LETTER ZETA"
	(0x005B 0x5B)	"LEFT SQUARE BRACKET"
	(0x2234 0x5C)	"THEREFORE"
	(0x005D 0x5D)	"RIGHT SQUARE BRACKET"
	(0x22A5 0x5E)	"UP TACK"
	(0x005F 0x5F)	"LOW LINE"
	(0xF8E5 0x60)	"radical extender"
	(0x03B1 0x61)	"GREEK SMALL LETTER ALPHA"
	(0x03B2 0x62)	"GREEK SMALL LETTER BETA"
	(0x03C7 0x63)	"GREEK SMALL LETTER CHI"
	(0x03B4 0x64)	"GREEK SMALL LETTER DELTA"
	(0x03B5 0x65)	"GREEK SMALL LETTER EPSILON"
	(0x03C6 0x66)	"GREEK SMALL LETTER PHI"
	(0x03B3 0x67)	"GREEK SMALL LETTER GAMMA"
	(0x03B7 0x68)	"GREEK SMALL LETTER ETA"
	(0x03B9 0x69)	"GREEK SMALL LETTER IOTA"
	(0x03D5 0x6A)	"GREEK PHI SYMBOL"
	(0x03BA 0x6B)	"GREEK SMALL LETTER KAPPA"
	(0x03BB 0x6C)	"GREEK SMALL LETTER LAMDA"
	(0x03BC 0x6D)	"GREEK SMALL LETTER MU"
	(0x03BD 0x6E)	"GREEK SMALL LETTER NU"
	(0x03BF 0x6F)	"GREEK SMALL LETTER OMICRON"
	(0x03C0 0x70)	"GREEK SMALL LETTER PI"
	(0x03B8 0x71)	"GREEK SMALL LETTER THETA"
	(0x03C1 0x72)	"GREEK SMALL LETTER RHO"
	(0x03C3 0x73)	"GREEK SMALL LETTER SIGMA"
	(0x03C4 0x74)	"GREEK SMALL LETTER TAU"
	(0x03C5 0x75)	"GREEK SMALL LETTER UPSILON"
	(0x03D6 0x76)	"GREEK PI SYMBOL"
	(0x03C9 0x77)	"GREEK SMALL LETTER OMEGA"
	(0x03BE 0x78)	"GREEK SMALL LETTER XI"
	(0x03C8 0x79)	"GREEK SMALL LETTER PSI"
	(0x03B6 0x7A)	"GREEK SMALL LETTER ZETA"
	(0x007B 0x7B)	"LEFT CURLY BRACKET"
	(0x007C 0x7C)	"VERTICAL LINE"
	(0x007D 0x7D)	"RIGHT CURLY BRACKET"
	(0x223C 0x7E)	"TILDE OPERATOR"
	(0x20AC 0xA0)	"EURO SIGN"
	(0x03D2 0xA1)	"GREEK UPSILON WITH HOOK SYMBOL"
	(0x2032 0xA2)	"PRIME"
	(0x2264 0xA3)	"LESS-THAN OR EQUAL TO"
	(0x2044 0xA4)	"FRACTION SLASH"
	(0x221E 0xA5)	"INFINITY"
	(0x0192 0xA6)	"LATIN SMALL LETTER F WITH HOOK"
	(0x2663 0xA7)	"BLACK CLUB SUIT"
	(0x2666 0xA8)	"BLACK DIAMOND SUIT"
	(0x2665 0xA9)	"BLACK HEART SUIT"
	(0x2660 0xAA)	"BLACK SPADE SUIT"
	(0x2194 0xAB)	"LEFT RIGHT ARROW"
	(0x2190 0xAC)	"LEFTWARDS ARROW"
	(0x2191 0xAD)	"UPWARDS ARROW"
	(0x2192 0xAE)	"RIGHTWARDS ARROW"
	(0x2193 0xAF)	"DOWNWARDS ARROW"
	(0x00B0 0xB0)	"DEGREE SIGN"
	(0x00B1 0xB1)	"PLUS-MINUS SIGN"
	(0x2033 0xB2)	"DOUBLE PRIME"
	(0x2265 0xB3)	"GREATER-THAN OR EQUAL TO"
	(0x00D7 0xB4)	"MULTIPLICATION SIGN"
	(0x221D 0xB5)	"PROPORTIONAL TO"
	(0x2202 0xB6)	"PARTIAL DIFFERENTIAL"
	(0x2022 0xB7)	"BULLET"
	(0x00F7 0xB8)	"DIVISION SIGN"
	(0x2260 0xB9)	"NOT EQUAL TO"
	(0x2261 0xBA)	"IDENTICAL TO"
	(0x2248 0xBB)	"ALMOST EQUAL TO"
	(0x2026 0xBC)	"HORIZONTAL ELLIPSIS"
	(0x23D0 0xBD)	"VERTICAL LINE EXTENSION (for arrows) Unicode 4.0 and later"
	(0x23AF 0xBE)	"HORIZONTAL LINE EXTENSION (for arrows) Unicode 3.2 and later"
	(0x21B5 0xBF)	"DOWNWARDS ARROW WITH CORNER LEFTWARDS"
	(0x2135 0xC0)	"ALEF SYMBOL"
	(0x2111 0xC1)	"BLACK-LETTER CAPITAL I"
	(0x211C 0xC2)	"BLACK-LETTER CAPITAL R"
	(0x2118 0xC3)	"SCRIPT CAPITAL P"
	(0x2297 0xC4)	"CIRCLED TIMES"
	(0x2295 0xC5)	"CIRCLED PLUS"
	(0x2205 0xC6)	"EMPTY SET"
	(0x2229 0xC7)	"INTERSECTION"
	(0x222A 0xC8)	"UNION"
	(0x2283 0xC9)	"SUPERSET OF"
	(0x2287 0xCA)	"SUPERSET OF OR EQUAL TO"
	(0x2284 0xCB)	"NOT A SUBSET OF"
	(0x2282 0xCC)	"SUBSET OF"
	(0x2286 0xCD)	"SUBSET OF OR EQUAL TO"
	(0x2208 0xCE)	"ELEMENT OF"
	(0x2209 0xCF)	"NOT AN ELEMENT OF"
	(0x2220 0xD0)	"ANGLE"
	(0x2207 0xD1)	"NABLA"
	(0x00AE 0xD2)	"REGISTERED SIGN serif"
	(0x00A9 0xD3)	"COPYRIGHT SIGN serif"
	(0x2122 0xD4)	"TRADE MARK SIGN serif"
	(0x220F 0xD5)	"N-ARY PRODUCT"
	(0x221A 0xD6)	"SQUARE ROOT"
	(0x22C5 0xD7)	"DOT OPERATOR"
	(0x00AC 0xD8)	"NOT SIGN"
	(0x2227 0xD9)	"LOGICAL AND"
	(0x2228 0xDA)	"LOGICAL OR"
	(0x21D4 0xDB)	"LEFT RIGHT DOUBLE ARROW"
	(0x21D0 0xDC)	"LEFTWARDS DOUBLE ARROW"
	(0x21D1 0xDD)	"UPWARDS DOUBLE ARROW"
	(0x21D2 0xDE)	"RIGHTWARDS DOUBLE ARROW"
	(0x21D3 0xDF)	"DOWNWARDS DOUBLE ARROW"
	(0x22C4 0xE0)	"DIAMOND OPERATOR"
	(0x3008 0xE1)	"LEFT ANGLE BRACKET"
	(0x00AE 0xE2)	"REGISTERED SIGN sans"
	(0x00A9 0xE3)	"COPYRIGHT SIGN sans"
	(0x2122 0xE4)	"TRADE MARK SIGN sans"
	(0x2211 0xE5)	"N-ARY SUMMATION"
	(0x239B 0xE6)	"LEFT PARENTHESIS UPPER HOOK Unicode 3.2 and later"
	(0x239C 0xE7)	"LEFT PARENTHESIS EXTENSION Unicode 3.2 and later"
	(0x239D 0xE8)	"LEFT PARENTHESIS LOWER HOOK Unicode 3.2 and later"
	(0x23A1 0xE9)	"LEFT SQUARE BRACKET UPPER CORNER Unicode 3.2 and later"
	(0x23A2 0xEA)	"LEFT SQUARE BRACKET EXTENSION Unicode 3.2 and later"
	(0x23A3 0xEB)	"LEFT SQUARE BRACKET LOWER CORNER Unicode 3.2 and later"
	(0x23A7 0xEC)	"LEFT CURLY BRACKET UPPER HOOK Unicode 3.2 and later"
	(0x23A8 0xED)	"LEFT CURLY BRACKET MIDDLE PIECE Unicode 3.2 and later"
	(0x23A9 0xEE)	"LEFT CURLY BRACKET LOWER HOOK Unicode 3.2 and later"
	(0x23AA 0xEF)	"CURLY BRACKET EXTENSION Unicode 3.2 and later"
	(0xF8FF 0xF0)	"Apple logo"
	(0x3009 0xF1)	"RIGHT ANGLE BRACKET"
	(0x222B 0xF2)	"INTEGRAL"
	(0x2320 0xF3)	"TOP HALF INTEGRAL"
	(0x23AE 0xF4)	"INTEGRAL EXTENSION Unicode 3.2 and later"
	(0x2321 0xF5)	"BOTTOM HALF INTEGRAL"
	(0x239E 0xF6)	"RIGHT PARENTHESIS UPPER HOOK Unicode 3.2 and later"
	(0x239F 0xF7)	"RIGHT PARENTHESIS EXTENSION Unicode 3.2 and later"
	(0x23A0 0xF8)	"RIGHT PARENTHESIS LOWER HOOK Unicode 3.2 and later"
	(0x23A4 0xF9)	"RIGHT SQUARE BRACKET UPPER CORNER Unicode 3.2 and later"
	(0x23A5 0xFA)	"RIGHT SQUARE BRACKET EXTENSION Unicode 3.2 and later"
	(0x23A6 0xFB)	"RIGHT SQUARE BRACKET LOWER CORNER Unicode 3.2 and later"
	(0x23AB 0xFC)	"RIGHT CURLY BRACKET UPPER HOOK Unicode 3.2 and later"
	(0x23AC 0xFD)	"RIGHT CURLY BRACKET MIDDLE PIECE Unicode 3.2 and later"
	(0x23AD 0xFE)	"RIGHT CURLY BRACKET LOWER HOOK Unicode 3.2 and later"
    ) inject: IdentityDictionary new into: [:map :unipss | map at: unipss first put: unipss second; yourself]
]

PostScriptFontMap := [
    IdentityDictionary new
	at: #'Times-R'		put: 'Times-Roman';
	at: #'Times-B'		put: 'Times-Bold';
	at: #'Times-S'		put: 'Times-Italic';
	at: #'Times-BS'		put: 'Times-BoldItalic';
	at: #'Helvetica-R'	put: 'Helvetica';
	at: #'Helvetica-B'	put: 'Helvetica-Bold';
	at: #'Helvetica-S'	put: 'Helvetica-Oblique';
	at: #'Helvetica-BS'	put: 'Helvetica-BoldOblique';
	at: #'Courier-R'	put: 'Courier';
	at: #'Courier-B'	put: 'Courier-Bold';
	at: #'Courier-S'	put: 'Courier-Oblique';
	at: #'Courier-BS'	put: 'Courier-BoldOblique';
	yourself
]

PostScriptStream : WriteStream ( currentFont )

PostScriptStream beginDocument	[ self beginDocument: 612,792 ]

PostScriptStream beginDocument: extent
[
    | w h |
    w := extent x.
    h := extent y.
    self
	nextPutAll: '<< /PageSize ['; print: w; space; print: h; nextPutAll: '] >> setpagedevice'; cr;
	nextPutAll: '/BOP { 36 '; print: h - 36; nextPutAll: ' translate 0 0 moveto } bind def\n';
	nextPutAll: '/EOP { 4 string cvs dup stringwidth pop initgraphics 2 div neg ';
			print: w // 2;
			nextPutAll: ' add 18 moveto show showpage } bind def\n';
	nextPutAll: '/readstring { currentfile exch readhexstring pop } bind def\n';
	nextPutAll: '/f { findfont exch scalefont setfont } bind def\n';
	nextPutAll: '/s { show } bind def\n';
	nextPutAll: '/t { translate 0 0 moveto } bind def\n';
	nextPutAll: '/x { 0 moveto } bind def\n'.
]

PostScriptStream beginPage: pageNumber
[
    self
	nextPutAll: '%%Page: '; print: pageNumber;
	nextPutAll: '\nBOP\n'
]

PostScriptStream origin: aPoint
[
    self print: aPoint x; space; print: aPoint y negated; nextPutAll: ' t\n'
]

PostScriptStream ensureFont: aFont
[
    | name |
    currentFont == aFont ifTrue: [^self].
    name := aFont name asString , '-'.
    aFont isPlain	ifTrue: [name := name , 'R'].
    aFont isBold	ifTrue: [name := name , 'B'].
    aFont isItalic	ifTrue: [name := name , 'S'].
    name := PostScriptFontMap
	at: name asSymbol
	ifAbsent:
	   [StdErr nextPutAll: 'substituting Times-Roman for unknown font ', name.
	    'Times-Roman'].
    self print: aFont pointSize; nextPutAll: ' /'; nextPutAll: name.
    self nextPutAll: ' f\n'.
    currentFont := aFont.
]

PostScriptStream moveToX: x	[ self print: x; nextPutAll: ' x ' ]

PostScriptStream nextPutUnicode: unicode
[
    | code font |
    unicode < 32 ifTrue: [^nil].
    code := UnicodeToPostScriptStandardMap at: unicode ifAbsent: [].
    code ifTrue: [^self nextPutCharacter: code].
    code := UnicodeToPostScriptSymbolMap at: unicode ifAbsent:
	[^StdErr nextPutAll: 'cannot print U+'; print: unicode base: 16 width: 4 padded: $0; cr].
    font := currentFont.
    currentFont := nil.
    self
	print: font pointSize; nextPutAll: ' /Symbol f ';
	nextPutCharacter: code;
	ensureFont: font
]

PostScriptStream nextPutCharacter: code	[ self nextPutAll: '(\\'; print: code base: 8 width: 3 padded: $0; nextPutAll: ')s\n' ]

PostScriptStream nextPutSurface: aSurface at: origin
[
    | w h |
    w := aSurface width.
    h := aSurface height.
    self
	nextPutAll: 'save\n';
	print: origin x; space; print: origin y; space; nextPutAll: ' t\n';
	nextPutAll: '/rpicstr '; print: w; nextPutAll: ' string def\n';
	nextPutAll: '/gpicstr '; print: w; nextPutAll: ' string def\n';
	nextPutAll: '/bpicstr '; print: w; nextPutAll: ' string def\n';
	print: w; space; print: h; nextPutAll: ' scale ';
	print: w; space; print: h; nextPutAll: ' 8 [ ';
	print: w; nextPutAll: ' 0 0 '; print: h negated; nextPutAll: ' 0 '; print: h; nextPutAll: ']'; cr;
	nextPutAll: '{ rpicstr readstring } { gpicstr readstring } { bpicstr readstring } true 3 colorimage\n'.
    0 to: h - 1 do: [:y |
	0 to: w - 1 do: [:x | self nextPutHex8: (aSurface redAt:   x at: y)].  self cr.
	0 to: w - 1 do: [:x | self nextPutHex8: (aSurface greenAt: x at: y)].  self cr.
	0 to: w - 1 do: [:x | self nextPutHex8: (aSurface blueAt:  x at: y)].  self cr].
    self nextPutAll: 'restore\n'.
]

PostScriptStream nextPutHex8: anInteger	[ anInteger printOn: self base: 16 width: 2 padded: $0 ]

PostScriptStream endPage: pageNumber	[ self print: pageNumber; nextPutAll: ' EOP\n' ]

PostScriptStream endDocument		[]
