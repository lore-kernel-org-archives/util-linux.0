Return-Path: linux-fsdevel-owner@vger.kernel.org
Date: Fri, 13 Dec 2013 09:18:48 +0100
From: Karel Zak <kzak@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Phillip Susi <psusi@ubuntu.com>, util-linux@vger.kernel.org,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: read only bind mount ignores ready only
Message-ID: <20131213081848.GM16572@x2.net.home>
References: <52A878C5.6050505@ubuntu.com>
 <20131212120544.GJ16572@x2.net.home>
 <CAJfpegvWeEb7Dtk8CMxLO4DB-xSLQMxLxccUPReU0GeQ=9d5MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJfpegvWeEb7Dtk8CMxLO4DB-xSLQMxLxccUPReU0GeQ=9d5MA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Dec 12, 2013 at 08:42:54PM +0100, Miklos Szeredi wrote:
> On Thu, Dec 12, 2013 at 1:05 PM, Karel Zak <kzak@redhat.com> wrote:
> > Miklos would be possible to fix kernel to accept MS_REC for
> > MS_REMOUNT|MS_BIND|MS_RDONLY operation? Please.
> 
> I really hate the current mount(2) API. It's a gigantic hack, and it's

 We all hate it, but we have to use it every day..

> nearing the end of its life anyway due to flags running out.

 well, the current problem with MS_REC is just one small inconsistence
 in the current MS_REMOUNT|MS_BIND semantic. It would be really nice
 to fix it now.

> So instead of adding more hacks, I think it would be better to think
> about adding a couple of syscalls that have clearly defined semantics.

 Yes, but it's (very) long term goal...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
