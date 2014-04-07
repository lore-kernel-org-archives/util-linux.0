Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:14725 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbaDGKgM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Apr 2014 06:36:12 -0400
Date: Mon, 7 Apr 2014 12:36:04 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] blockdev(8): Some minor corrections to the manual
Message-ID: <20140407103604.GH22126@x2.net.home>
References: <20140402232331.GA23303@rhi.hi.is>
 <CAG27Bk2m=Y-kr_mrB=gssKB-XRM+4+3kkKmWkUisgHtNDe8wtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk2m=Y-kr_mrB=gssKB-XRM+4+3kkKmWkUisgHtNDe8wtw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> On 3 April 2014 00:23, Bjarni Ingi Gislason <bjarniig@rhi.hi.is> wrote:
> >   Patch is in the attachment

 Bjarni, I have merged all your patches, but Sami is right. It would
 be nice to have your patches in better format next time. Thanks!

    Karel

On Thu, Apr 03, 2014 at 09:49:54AM +0100, Sami Kerola wrote:
> git clone git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git
> util-linux
> git config --global user.name "Bjarni Ingi Gislason"
> git config --global user.email bjarniig@rhi.hi.is
> git branch bjani
> git checkout bjarni
> # while patches {
> git apply <each of your patch separately>
> git add .
> git commit -s
> # }
> 
> # create patches
> git format-patch -n master ~/ul-patches/
> 
> # test that you can send/receive emails
> git send-email --to bjarniig@rhi.hi.is ~/ul-patches/*
> # if yes, and all looks good
> git send-email --to util-linux@vger.kernel.org ~/ul-patches/*

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
