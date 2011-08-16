Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:17606 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098Ab1HPKq5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 16 Aug 2011 06:46:57 -0400
Date: Tue, 16 Aug 2011 12:46:52 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Subject: Re: man-pages and usage() howto
Message-ID: <20110816104652.GA14535@nb.net.home>
References: <20110815141948.GH2038@nb.net.home> <CAG27Bk0LpsVdCJhvOAstC_OpckzfBB05kcZcN_ByF_i_JQU6SQ@mail.gmail.com> <1313485424.19019.140258130122469@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1313485424.19019.140258130122469@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 16, 2011 at 11:03:44AM +0200, Benno Schulenberg wrote:
> > >        command [options] file
> 
> If in the usage() help text the arguments of options are written in
> uppercase, wouldn't it be more consistent to then also write the

 It depends, Semi's version is uppercase, but my (findmnt, blkid,
 lsblk, ...) is <lowercase> :-) 

> About the other things I have not yet an opinion.

 I made the decision, --option <argument>. We can play with it little
 bit more in the next release. Now I'd like to release it...

 It would be also nice to sync man pages with usage() format. Note
 that man pages changes are acceptable for -rc2.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
