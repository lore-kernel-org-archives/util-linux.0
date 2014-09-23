Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54042 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755059AbaIWQZa (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 23 Sep 2014 12:25:30 -0400
Date: Tue, 23 Sep 2014 18:25:07 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 01/10] textual: use angular brackets around each
 individual argument
Message-ID: <20140923162507.GA26272@x2.net.home>
References: <1411416940-3249-1-git-send-email-bensberg@justemail.net>
 <1411417110.2384317.170486897.6828935E@webmail.messagingengine.com>
 <CAG27Bk3EgO9k6uN+nDWny2G0MMrn97Jd5sFMRvPBEHO-hZZSBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk3EgO9k6uN+nDWny2G0MMrn97Jd5sFMRvPBEHO-hZZSBg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 23, 2014 at 02:26:41PM +0100, Sami Kerola wrote:
> On 22 September 2014 21:18, Benno Schulenberg <bensberg@justemail.net> wrote:
> >
> > On Mon, Sep 22, 2014, at 22:15, Benno Schulenberg wrote:
> >> -     fputs(_(" -u, --user <name|id>   interpret argument as username or user ID\n"), out);
> >> +     fputs(_(" -u, --user <name>|<id> interpret argument as username or user ID\n"), out);
> >
> > Sami?  How come that this change, that you seemed to have applied,
> > wasn't propagated to the github branch that Karel pulled?
> 
> Hi Benno,
> 
> I don't know. Maybe Karel did not fetch the latest changes before
> merging. Well, at least
> writing a patch to correct the angle brackets is easy.

 git log:

   Merge branch 'renice' of git://github.com/kerolasa/lelux-utiliteetit

 and it seems the latest version of the branch.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
