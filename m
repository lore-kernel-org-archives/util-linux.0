Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755284AbdDFIl2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 6 Apr 2017 04:41:28 -0400
Date: Thu, 6 Apr 2017 10:41:19 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/3] agetty: make --remote to forward --nohostname as -H
 to login
Message-ID: <20170406084119.fpjzutu73sc4bdbg@ws.net.home>
References: <20170402081436.861-1-kerolasa@iki.fi>
 <20170402081436.861-3-kerolasa@iki.fi>
 <bb07f30a-74e6-0961-758a-67383ae417bf@gmx.com>
 <CAG27Bk36WxLCGDtWk+WHrK4eDqsjoQcNdc1sKxhpN4BmAEFmWA@mail.gmail.com>
 <CAG27Bk2_YT8jEOrxb4ANwH59CAw-ramfZkpCBDHbAqkkDHOfwQ@mail.gmail.com>
 <aac8c8b6-1c10-9645-3538-2f5944fbfcb1@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <aac8c8b6-1c10-9645-3538-2f5944fbfcb1@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 05, 2017 at 07:33:58PM -0400, J William Piggott wrote:
> 
> On 04/03/2017 05:20 PM, Sami Kerola wrote:
> > On 3 April 2017 at 09:40, Sami Kerola <kerolasa@iki.fi> wrote:
> >> On 3 April 2017 at 02:13, J William Piggott <elseifthen@gmx.com> wrote:
> >>>
> >>> Hey Sami, since you're here you might want to fix this too?
> >>
> >> Hi JWP,
> >>
> >> Let me split the change in two:
> >>
> >> 1. --nohostname option forward + minimal manual change
> >> 2. manual page update
> >>
> >> Karel, please hold on with these three changes. I will push changes to
> >> a some branch in my git and tell when the stuff is fast forwardable.
> > 
> > Here are the updated changes, first one is the minimal option forwarding
> > and second tries to make manual page better.
> > 
> > https://github.com/kerolasa/lelux-utiliteetit/commit/343cc275591327bc2094f88387f09702a542dc8c
> > https://github.com/kerolasa/lelux-utiliteetit/commit/c9151874b67a652b7095243fde2203ab8cd7d107
> > 
> > Branch name is: 2017wk13
> >
> 
> Sami,
> 
> Rather than trying to comment on all of your changes, I'm submitting my
> suggestions via the attached patch. It applies over your 2017wk13 branch.
> 
> I changed --login-options according to Karel's comments. Please check
> that I understood him correctly. Instead of trying to illustrate it's use
> in the replaceable argument, I moved it to an example.
> 
> I added some language explaining the purpose of --remote. Please check
> that I understood that correctly also.

 Can you use master branch? Sami's patches are already merged and I
 did some changes to the man page too.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
