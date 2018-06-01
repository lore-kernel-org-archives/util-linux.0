Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: hardlink util -- files de-duplication
Date: Fri, 1 Jun 2018 15:08:38 +0200
Cc: "util-linux" <util-linux@vger.kernel.org>,
 Kevin Fenzi <kevin@scrye.com>
References: <20180601113807.ghf6dtcd5xa6qptu@ws.net.home>
In-Reply-To: <20180601113807.ghf6dtcd5xa6qptu@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201806011508.38470.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Friday 01 June 2018, Karel Zak wrote:
> For last 17 years in Red Hat based distros is available hardlink(1)
> util, man hardlink:
>
>    hardlink traverses one or more directories searching for duplicate
>    files.  When it finds duplicate files, it uses one of them as the
>    master.  It then removes all other duplicates and places a
> hardlink for each one pointing to the master file.  This allows for
> conservation of disk space where multiple directories on a single
> filesystem contain many  dupli cate files.
>
>    ...
>
> the util is little bit orphaned, what about to add this util to
> util-linux to make it available for another distros and keep it
> maintained in serious way? ;-)

+1

>
>    https://src.fedoraproject.org/cgit/rpms/hardlink.git/

The original and almost identical repo is this:
  https://pagure.io/hardlink.git

I've CC'ed the project admin Kevin Fenzi.

> It's one .c file.
>
> Comments & objections?
>
>     Karel
