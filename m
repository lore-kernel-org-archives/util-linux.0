Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39924 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752549Ab1GUPnH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 21 Jul 2011 11:43:07 -0400
Date: Thu, 21 Jul 2011 17:43:03 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [git pull] schedutils
Message-ID: <20110721154303.GF22568@nb.net.home>
References: <CAG27Bk0XXawQERH19+iUguDame2Pts_+bvrt8Of0+ib9KSW3NA@mail.gmail.com> <20110718221751.GD4354@nb.redhat.com> <CAG27Bk3vs54m7b6y_M_uq4RuyPBn-yhAEt2GhicsyY8F_+jJfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAG27Bk3vs54m7b6y_M_uq4RuyPBn-yhAEt2GhicsyY8F_+jJfw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 20, 2011 at 10:15:13AM +0200, Sami Kerola wrote:
> >> -                     ioprio = strtol_or_err(optarg, _("failed to parse class data"));
> >> +                     ioprio = strtol_or_err(optarg, _("failed to parse priority"));
> >
> > well, the original kernel Documentation/block/ioprio.txt is talking
> > about "class data" and I think it would be better to follow kernel
> > here. Maybe one day the mask for the syscall will used for a different
> > things than only for priority...
> 
> I read kernel documentation using priority, class data and level as
> synonyms. To me the `class data' is most confusing because it gets
> mixed up with `class'. As you did not like `priority' I do my last
> attempt to change the word and used `level'. How that would sound?

 The 'ioprio' in the syscall:

     syscall(SYS_ioprio_set, which, who, ioprio);

 encodes two information:

    IOPRIO_PRIO_CLASS  - e.g. realtime, idle, ...
    IOPRIO_PRIO_DATA   - e.g. 0-7

 this is reason why the docs is talking about "class" and "class data".

 Anyway, merged with some minor changes and --classdata option :-)
 

 Minor notes:

 * .PP in man page within .IP block does not have the same meaning
   like blank line

 * I think that 
        -c, --class NUM
   is better than 
        -c, --class=NUM


 I have fixed this in ionice man page, but not in usage(). It would be
 nice to use in all man pages and usage() functions the same syntax.
 Maybe we can create any template or so to have it documented.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
