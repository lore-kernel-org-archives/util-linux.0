Return-Path: bigeasy@linutronix.de
Date: Wed, 29 Feb 2012 22:38:08 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] Add uuid to the linker flags if using built
 LIBBLKID
Message-ID: <20120229213808.GB11628@linutronix.de>
References: <1330103768-32139-1-git-send-email-bigeasy@linutronix.de>
 <1330103768-32139-2-git-send-email-bigeasy@linutronix.de>
 <20120228143537.GD22034@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20120228143537.GD22034@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

* Karel Zak | 2012-02-28 15:35:37 [+0100]:

>> --- a/config/include-Makefile.am
>> +++ b/config/include-Makefile.am
>> @@ -31,6 +31,9 @@ ul_libuuid_la = $(top_builddir)/libuuid/src/libuuid.la
>>  $(ul_libuuid_la):
>>  	$(MAKE) -C $(ul_libuuid_builddir)
>>  
>> +if BUILD_LIBBLKID
>
> I guess you mean "if BUILD_LIBUUID".

I don't think so. Because if I build LIBBLKID it requires syms from
LIBUUID.

>> + ul_libblkid_la += $(ul_libuuid_la)
>> +endif
>
> Hmm... I don't like this, it creates explicit dependence, libtool
> should be smart enough to maintain dependencies dynamically.
>
> We have libuuid.la in libblkid_la_LIBADD (see in libblkid/src/Makefile.am) and
> on my system it generates the final libblkid.la with
>
>   # Libraries that this one depends upon.
>   dependency_libs='/home/projects/util-linux/util-linux/libuuid/src/libuuid.la'
>
>
> It would be nice to know more details about your environment to
> reproduce this problem. If I will be able to reproduce the problem
> then I can also add regression test (for cross compiling).

configured by
|   $ ./configure --host=powerpc-linux-gnu --without-ncurses host_alias=powerpc-linux-gnu --no-create --no-recursion

according to config.log (everything starting with host_alias was not
added me). It is a cross compiler environment with no headers/libs. So
both libs (uuid and libblkid should be built by util-linux). After a
make I end up with:

|make[4]: Nothing to be done for `all-am'.
|make[4]: Leaving directory `/home/bigeasy/work/git/util-linux/libblkid/src'
|make[3]: Leaving directory `/home/bigeasy/work/git/util-linux/libblkid/src'
|Making all in samples
|make[3]: Entering directory `/home/bigeasy/work/git/util-linux/libblkid/samples'
|  CCLD   mkfs
|/usr/lib/gcc/powerpc-linux-gnu/4.4.5/../../../../powerpc-linux-gnu/bin/ld: warning: libuuid.so.1, needed by ../../libblkid/src/.libs/libblkid.so, not found (try using -rpath or -rpath-link)
|../../libblkid/src/.libs/libblkid.so: undefined reference to `uuid_unparse@UUID_1.0'
|collect2: ld returned 1 exit status
|make[3]: *** [mkfs] Error 1

>
>    Karel

Sebastian
