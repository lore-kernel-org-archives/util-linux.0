Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ve0-f174.google.com ([209.85.128.174]:47176 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711Ab3C1LWr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 28 Mar 2013 07:22:47 -0400
Received: by mail-ve0-f174.google.com with SMTP id jz10so5167345veb.5
        for <util-linux@vger.kernel.org>; Thu, 28 Mar 2013 04:22:46 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1364422072-23552-2-git-send-email-kerolasa@iki.fi>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
	<1364422072-23552-2-git-send-email-kerolasa@iki.fi>
Date: Thu, 28 Mar 2013 11:22:46 +0000
Message-ID: <CAG27Bk08gHsgy-mdJu_a_QE6oimShXxYVJFaSpZ_O9Xybbe8+w@mail.gmail.com>
Subject: Re: [PATCH 01/10] bash-completion: add bash completetion configure option
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 27, 2013 at 10:07 PM, Sami Kerola <kerolasa@iki.fi> wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  Makefile.am                    |  5 +++++
>  configure.ac                   | 13 +++++++++++++
>  shell-completion/Makemodule.am |  1 +
>  3 files changed, 19 insertions(+)
>  create mode 100644 shell-completion/Makemodule.am

Do we need './configure
--disable-overwriting-bash-compilation-package-files'? I realized some
of the files I wrote will conflicting with the

http://anonscm.debian.org/gitweb/?p=bash-completion/bash-completion.git;a=tree;f=completions

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
