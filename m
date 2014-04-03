Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36528 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162653AbaDCIty (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 3 Apr 2014 04:49:54 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so1526127pab.10
        for <util-linux@vger.kernel.org>; Thu, 03 Apr 2014 01:49:54 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20140402232331.GA23303@rhi.hi.is>
References: <20140402232331.GA23303@rhi.hi.is>
Date: Thu, 3 Apr 2014 09:49:54 +0100
Message-ID: <CAG27Bk2m=Y-kr_mrB=gssKB-XRM+4+3kkKmWkUisgHtNDe8wtw@mail.gmail.com>
Subject: Re: [PATCH] blockdev(8): Some minor corrections to the manual
From: Sami Kerola <kerolasa@iki.fi>
To: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 3 April 2014 00:23, Bjarni Ingi Gislason <bjarniig@rhi.hi.is> wrote:
>   Patch is in the attachment

Hi Bjarni,

Great to see new contributor.

It seems you are sending quite a few patches, and it would be better
to get them in git native format. Looking your message I think you
have downloaded release package, made changes and used 'diff -u'.
That's not too bad when sending a small number of changes. To me your
number your patches is exceeding what I would describe as small
number.

Could you get yourself a clone of this project. Configure your git,
and resubmit.

git clone git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git
util-linux
git config --global user.name "Bjarni Ingi Gislason"
git config --global user.email bjarniig@rhi.hi.is
git branch bjani
git checkout bjarni
# while patches {
git apply <each of your patch separately>
git add .
git commit -s
# }

# create patches
git format-patch -n master ~/ul-patches/

# test that you can send/receive emails
git send-email --to bjarniig@rhi.hi.is ~/ul-patches/*
# if yes, and all looks good
git send-email --to util-linux@vger.kernel.org ~/ul-patches/*

If you end struggling with email for hours it might be easier to save
all files in ul-patches directory to a single tar.gz file, and send it
as an attachment. This is not quite as good as seeing patches in email
list as message body, but at least the patches would be in easy to
process format.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
