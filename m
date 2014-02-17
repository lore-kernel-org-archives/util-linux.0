Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13566 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705AbaBQMtl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 17 Feb 2014 07:49:41 -0500
Date: Mon, 17 Feb 2014 13:49:33 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Mike Frysinger <vapier@gentoo.org>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/3] tests: automatic whitespace trimming broke earlier
 commit
Message-ID: <20140217124933.GG2254@x2.net.home>
References: <1389816953-11531-1-git-send-email-kerolasa@iki.fi>
 <1389816953-11531-3-git-send-email-kerolasa@iki.fi>
 <7637074.9zSARVxuln@vapier>
 <CAG27Bk1tf+OLsOrhCWA9e6ZrPOF7K779rq_9FKD-_Sj0H7idUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk1tf+OLsOrhCWA9e6ZrPOF7K779rq_9FKD-_Sj0H7idUg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 17, 2014 at 09:01:51AM +0000, Sami Kerola wrote:
> Karel, is it possible something in your setup is removing trailing

 yes

   $ git config --list | grep space
   apply.whitespace=strip

 I guess that

   $ git config apply.whitespace warn
 
 is a better way...
 
> spaces? Perhaps you could  simply copy the cal test outputs to
> expected directory, so that we can rid of this issue for good.

 Fixed, sorry.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
