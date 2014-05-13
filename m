Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: "Dr. Werner Fink" <werner@suse.de>
Subject: Re: [PATCH 1/4] Avoid that agetty nor sulogin are fooled by a running plymouth
Date: Tue, 13 May 2014 14:10:52 +0200
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <1399543765-31106-1-git-send-email-werner@suse.de> <20140513085658.GM8951@x2.net.home> <20140513104222.GA16787@boole.suse.de>
In-Reply-To: <20140513104222.GA16787@boole.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201405131410.52423.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Tuesday 13 May 2014, Dr. Werner Fink wrote:
> In my experience plymouth has some more further side effects if on is
> using a further serial console or if there is no virtual console
> (s390 and some x86_64 server systems).  Maybe upstream of plymouth is
> not aware that in server business a virtual console used for graphic
> is not that common.

I am more wondering why we are using plymouth in server business then. 
But that's an openSUSE issue ;)

cu,
Rudi
