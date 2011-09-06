Return-Path: heiko.carstens@de.ibm.com
Message-Id: <20110906005251.497675140@de.ibm.com>
Date: Tue, 06 Sep 2011 02:52:51 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 00/11] various lscpu changes
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

another set of patches against lscpu. Since you didn't have chance to push
out your local tree to kernel.org yet, I simply based them on my old lscpu
branch which you applied on your local tree:

 git://git.kernel.org/pub/scm/linux/kernel/git/heiko/util-linux.git lscpu

So, in theory there shouldn't be any merge conflicts ;)

Also, due to master.kernel.org being down I didn't set up a new git branch.


Anyway, the most notable change/addition is the new "-e|--extended" option
which prints a human readable extended cpu table:

CPU BOOK SOCKET CORE ONLINE CONFIGURED POLARIZATION ADDRESS
0   0    0      0    yes    yes        vert-medium  0
1   0    0      1    yes    yes        vert-low     1
2   0    0      2    yes    yes        vert-low     2
3   0    1      3    yes    yes        vert-low     3
4   0    1      4    yes    yes        vert-low     4
5   0    1      5    yes    yes        vert-low     5
6   1    2      6    yes    yes        vert-low     6
7   1    2      -    no     yes        vert-low     7
8   1    2      -    no     yes        vert-low     8
9   -    -      -    no     no         -            9
10  -    -      -    no     no         -            10
11  1    3      7    yes    yes        vert-low     11
12  1    3      8    yes    yes        vert-low     12
13  1    3      9    yes    yes        vert-low     13
14  1    3      10   yes    yes        vert-low     14
15  1    4      11   yes    yes        vert-low     15
16  1    5      12   yes    yes        vert-low     16
17  1    5      13   yes    yes        vert-low     17
18  1    5      14   yes    yes        vert-low     18
19  1    6      15   yes    yes        vert-low     19

Hopefully the patches don't look too bad. :)

Thanks,
Heiko
