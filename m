Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38332 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754292Ab3C2Jm7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 29 Mar 2013 05:42:59 -0400
Date: Fri, 29 Mar 2013 10:42:18 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux@vger.kernel.org, kerolasa@iki.fi,
        bash-completion-devel@lists.alioth.debian.org
Subject: Re: [PATCH 01/10] bash-completion: add bash completetion configure
 option
Message-ID: <20130329094218.GG24678@x2.net.home>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
 <1364422072-23552-2-git-send-email-kerolasa@iki.fi>
 <CAG27Bk08gHsgy-mdJu_a_QE6oimShXxYVJFaSpZ_O9Xybbe8+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk08gHsgy-mdJu_a_QE6oimShXxYVJFaSpZ_O9Xybbe8+w@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 28, 2013 at 11:22:46AM +0000, Sami Kerola wrote:
> On Wed, Mar 27, 2013 at 10:07 PM, Sami Kerola <kerolasa@iki.fi> wrote:
> > Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> > ---
> >  Makefile.am                    |  5 +++++
> >  configure.ac                   | 13 +++++++++++++
> >  shell-completion/Makemodule.am |  1 +
> >  3 files changed, 19 insertions(+)
> >  create mode 100644 shell-completion/Makemodule.am
> 
> Do we need './configure
> --disable-overwriting-bash-compilation-package-files'?

 Hmm... not sure, it's distro specific decision/policy.

 Maybe we need --disable-bash-completion, it should enough.

> I realized some of the files I wrote will conflicting with the

 Which files? We can add some info to ReleaseNotes to make it easy for
 distros.

> http://anonscm.debian.org/gitweb/?p=bash-completion/bash-completion.git;a=tree;f=completions

 What about to use .ul (or .util-linux) suffix for the conflicting
 files and in the bash-completion package check for these files and use
 it if exists? See for example:

  http://anonscm.debian.org/gitweb/?p=bash-completion/bash-completion.git;a=blob;f=completions/umount

 CC: to bash-completion-devel@lists.alioth.debian.org, maybe they
 already have any idea how to resolve the conflicts between packages.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
