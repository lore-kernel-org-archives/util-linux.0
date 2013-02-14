Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58428 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760646Ab3BNOkx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Feb 2013 09:40:53 -0500
Date: Thu, 14 Feb 2013 15:40:49 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Luis Aranguren <pizzaman@hotmail.com>, util-linux@vger.kernel.org
Subject: Re: Hypervisor & Virtualization lscpu test fail
Message-ID: <20130214144049.GF19379@x2.net.home>
References: <BLU0-SMTP36414270EB979DF67318E53D50B0@phx.gbl>
 <CAG27Bk2XQxWUFZPuQP8JWJaJ5OuCrxspk==9saGO-Xv6yk=7Sg@mail.gmail.com>
 <BLU0-SMTP144C815AE93C94E539C372CD50A0@phx.gbl>
 <CAG27Bk0ddxfVP98dxWiS+XjoGcM2gv1O78L3wBcVXDKNjMjMQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0ddxfVP98dxWiS+XjoGcM2gv1O78L3wBcVXDKNjMjMQg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 11, 2013 at 10:56:22PM +0000, Sami Kerola wrote:
> On Mon, Feb 11, 2013 at 1:44 AM, Luis Aranguren <pizzaman@hotmail.com> wrote:
> > Thanks for the reply. I include the output file from mk-input.sh, I have
> > to note that there were a three permission denied instances.
> 
> Oh, I did not look the code before asking the stuff from /proc/. It
> seems the lscpu detects virtualization by looking characteristics of
> cpu. See cpuid() from
> 
> https://github.com/karelzak/util-linux/blob/master/sys-utils/lscpu.c#L453
> 
> Perhaps turning off call to that function is the most sensible thing
> to do. Any thoughts?

 Yes, good idea. Implemented, pushed.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
