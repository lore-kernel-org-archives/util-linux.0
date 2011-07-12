Return-Path: pgf@laptop.org
To: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] evstate: new utility for querying evdev key/switch/event state
From: Paul Fox <pgf@laptop.org>
cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Karel Zak <kzak@redhat.com>,
        util-linux@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
        linux-input@vger.kernel.org
In-reply-to: <CAGq3pz4ueyiTg1usRwangBJfuPwYPoOC0k83ygKs2RikfOQyGw@mail.gmail.com> (sfid-20110711_124927_157078_A3E8F7E6)
References: <20110709132046.90A119D401C@zog.reactivated.net> <20110711121836.GJ5214@nb.net.home> <20110711163917.GA1648@core.coreip.homeip.net> <CAGq3pz4ueyiTg1usRwangBJfuPwYPoOC0k83ygKs2RikfOQyGw@mail.gmail.com> (sfid-20110711_124927_157078_A3E8F7E6)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 12 Jul 2011 16:07:00 -0400
Message-ID: <15489.1310501220@foxharp.boston.ma.us>
List-ID: <util-linux.vger.kernel.org>

daniel wrote:
 > On 11 July 2011 17:39, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
 > > Now I'd say that this utility probably better fit into linuxconsole
 > > project with the rest of input-related utilities...
 > 
 > http://sourceforge.net/projects/linuxconsole/ ?
 > 
 > This must have been what you were referring to before. Yes, this looks
 > like a more appropriate home. I'll take it in that direction.

i disagree.  the contents of that package seems to be mostly for
testing and legacy support.  access to the state of input switches in
a generic way seems far more generally useful than that.

i would rather not see the sysfs state variable go away in the first
place -- it's too convenient to use, and inexpensive to implement --
needing an ioctl for this seems like a step backwards.  but barring
that, relegating the evstate functionality to linuxconsole seems wrong.
(for instance, i don't think the OLPC laptop distros have a need for
any of the other utilities in linuxconsole.)

paul
=---------------------
 paul fox, pgf@laptop.org
