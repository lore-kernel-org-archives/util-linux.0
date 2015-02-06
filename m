Return-Path: bruce.dubbs@gmail.com
Message-ID: <54D406A0.2060904@gmail.com>
Date: Thu, 05 Feb 2015 18:11:12 -0600
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: Benno Schulenberg <bensberg@justemail.net>, Karel Zak <kzak@redhat.com>
CC: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [ANNOUNCE] util-linux v2.26-rc2
References: <20150204115353.GC1238@ws.net.home> <1423172910.109711.223698217.4EC40FCF@webmail.messagingengine.com>
In-Reply-To: <1423172910.109711.223698217.4EC40FCF@webmail.messagingengine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <util-linux.vger.kernel.org>

Benno Schulenberg wrote:
>
> On Wed, Feb 4, 2015, at 12:53, Karel Zak wrote:
>>
>> The util-linux release v2.26-rc2 is available at
>>
>>    ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.26
>
> It compiles without error, but shows these warnings along the way:
>
> libfdisk/src/dos.c: In function 'add_partition':
> libfdisk/src/dos.c:1204: warning: format '%ju' expects type 'uintmax_t', but argument 4 has type 'long unsigned int'
>
> sys-utils/ipcs.c: In function ‘do_shm’:
> sys-utils/ipcs.c:241: warning: dereferencing pointer ‘shm_info’ does break strict-aliasing rules
> sys-utils/ipcs.c:241: warning: dereferencing pointer ‘shm_info’ does break strict-aliasing rules
> sys-utils/ipcs.c:241: warning: dereferencing pointer ‘shm_info’ does break strict-aliasing rules
> sys-utils/ipcs.c:241: warning: dereferencing pointer ‘shm_info’ does break strict-aliasing rules
> sys-utils/ipcs.c:241: warning: dereferencing pointer ‘shm_info’ does break strict-aliasing rules
> sys-utils/ipcs.c:241: warning: dereferencing pointer ‘shm_info’ does break strict-aliasing rules
> sys-utils/ipcs.c:223: note: initialized from here
>
> sys-utils/ipcutils.c: In function ‘ipc_shm_get_limits’:
> sys-utils/ipcutils.c:92: warning: dereferencing pointer ‘shminfo’ does break strict-aliasing rules
> sys-utils/ipcutils.c:91: warning: dereferencing pointer ‘shminfo’ does break strict-aliasing rules
> sys-utils/ipcutils.c:90: warning: dereferencing pointer ‘shminfo’ does break strict-aliasing rules
> sys-utils/ipcutils.c:89: note: initialized from here

You do not say what compiler or architecture you are using.  I am using 
gcc-4.9.2 and both sys-utils/ipcs.c and sys-utils/ipcutils.c build for 
me without any warnings.

My build of dos.c is done with:

/bin/sh ./libtool  --tag=CC   --mode=compile gcc -std=gnu99 
-DHAVE_CONFIG_H -I.  -include config.h -I./include 
-DLOCALEDIR=\"/usr/share/locale\" -D_PATH_LOCALSTATEDIR=\"/run\" 
-I./libuuid/src -I./libfdisk/src -I./libfdisk/src -I./libblkid/src -g 
-O2 -MT libfdisk/src/libfdisk_la-dos.lo -MD -MP -MF 
libfdisk/src/.deps/libfdisk_la-dos.Tpo -c -o 
libfdisk/src/libfdisk_la-dos.lo `test -f 'libfdisk/src/dos.c' || echo 
'./'`libfdisk/src/dos.c

and it does not provide any warnings either.

My host is a Intel(R) Core(TM) i7.

   -- Bruce
