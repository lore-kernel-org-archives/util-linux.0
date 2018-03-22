Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [ANNOUNCE] util-linux v2.32
Date: Thu, 22 Mar 2018 12:20:27 +0100
Cc: util-linux@vger.kernel.org
References: <20180321145323.l6ulgds4zfycfttp@ws.net.home> <201803221047.14002.sweet_f_a@gmx.de> <20180322102455.wqowcj4iphqstgya@ws.net.home>
In-Reply-To: <20180322102455.wqowcj4iphqstgya@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201803221220.27851.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Thursday 22 March 2018 at 11:24, you wrote:
> On Thu, Mar 22, 2018 at 10:47:13AM +0100, Ruediger Meier wrote:
> > $ diff -uw  /tmp/checkusage--help-2.31.2 /tmp/checkusage--help-2.32
>
> Cool. Added to my release check list. Thanks.

Just noticed another nice diff option to see quickly which command a
change belongs too.

$ diff -u -w --show-function-line="^##"  old new
[...]
@@ -447,6 +458,7 @@ #### dmesg
  -l, --level <list>          restrict output to defined levels
  -n, --console-level <level> set level of messages printed to console
  -P, --nopager               do not pipe output into a pager
+ -p, --force-prefix          force timestamp output on each line of multi-line messages
  -r, --raw                   print the raw message buffer
  -S, --syslog                force to use syslog(2) rather than /dev/kmsg
  -s, --buffer-size <size>    buffer size to query the kernel ring buffer
@@ -2363,6 +2380,7 @@ #### setsid

 Options:
  -c, --ctty     set the controlling terminal to the current one
+ -f, --fork     always fork
  -w, --wait     wait program to exit, and use the same return
  -h, --help     display this help
  -V, --version  display version


cu,
Rudi
