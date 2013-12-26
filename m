Return-Path: kmp@linux.vnet.ibm.com
Message-ID: <52BBD37B.30609@linux.vnet.ibm.com>
Date: Thu, 26 Dec 2013 12:28:03 +0530
From: Madhu Pavan <kmp@linux.vnet.ibm.com>
MIME-Version: 1.0
To: kzak@redhat.com
CC: util-linux@vger.kernel.org, deepakcs@linux.vnet.ibm.com,
        athunugu@linux.vnet.ibm.com
Subject: util-linux-2.24 not compatible with ppc64le architecture
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <util-linux.vger.kernel.org>


Hi Karel Zak,

We are in the process of adding support for new arch (ppc64le) and as 
part of that we wanted to send patches for config.guess and configure as 
appropriate.

util-linux-2.24 could not be built on ppc64le because it had an outdated 
configure/config.guess/libtool.m4. Since your pkg uses libtool and the 
latest tarball of your pkg didn't build on ppc64le due to outdated 
libtool present on your system. We wanted to request you to upgrade your 
libtool to the alpha release of libtool which has all the bits and 
pieces needed for ppc64le support.

In that context, I wanted to confirm the below

1) Should we send patches to 'util-linux@vger.kernel.org' mailing list 
or there is some other mailing list?

2) New libtool alpha release which supports ppc64le arch is available, 
you may  pick up the alpha release from either of the below:

ftp://alpha.gnu.org/gnu/libtool/libtool-2.4.2.418.tar.gz (1.6MB)

ftp://alpha.gnu.org/gnu/libtool/libtool-2.4.2.418.tar.xz (920KB)

It would be great if you can install this new libtool which supports 
ppc64le, and spin the pkg and let us know the new tar availability. We 
can test it on ppc64le architecture for you. Please let me know if you 
are planning to release or spin newer version.

Currently I used

https://www.kernel.org/pub/linux/utils/util-linux/v2.24/util-linux-2.24.tar.xz

Which does not have ppc64le support.

Your response is highly appreciated.

Thanks in advance,
Madhu Pavan Kothapally
