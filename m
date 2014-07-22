Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:3970 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754164AbaGVKNu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 22 Jul 2014 06:13:50 -0400
Date: Tue, 22 Jul 2014 12:13:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/6] pull: rename fixes
Message-ID: <20140722101339.GA26781@x2.net.home>
References: <1403433117-32652-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403433117-32652-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 22, 2014 at 11:31:51AM +0100, Sami Kerola wrote:
> Sami Kerola (6):
>   rename: allow renaming in subdirectories
>   tests: add function to change directory reliable way
>   tests: use ts_cd everywhere to change direcrory
>   tests: add rename(1) checks
>   rename: continue despite something failed
>   rename: use function pointer to select file or symlink operation

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
