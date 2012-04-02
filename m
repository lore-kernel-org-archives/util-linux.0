Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:29395 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669Ab2DBMMg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Apr 2012 08:12:36 -0400
Date: Mon, 2 Apr 2012 14:12:31 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux@vger.kernel.org,
        =?iso-8859-1?Q?P=E1draig?= Brady <P@draigbrady.com>
Subject: Re: [PATCH 3/3] chkdupexe: reimplement command in C
Message-ID: <20120402121231.GE1084@x2.net.home>
References: <20120330150457.GE23437@x2.net.home>
 <1333304372-25944-1-git-send-email-kerolasa@iki.fi>
 <1333304372-25944-4-git-send-email-kerolasa@iki.fi>
 <20120402111029.GA1084@x2.net.home>
 <CAG27Bk2oU12RWj=HWqE7hbx0c1f_ib=d6NCn8uQ1H1C3HGoLuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk2oU12RWj=HWqE7hbx0c1f_ib=d6NCn8uQ1H1C3HGoLuA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 02, 2012 at 01:53:23PM +0200, Sami Kerola wrote:
> I am in favour of removal. As you said few, if anyone, is using this
> command and to be honest I do not know why I would use it. Duplicated

I agree ... so, we need --enable-chkdupexe (disabled by default)
and Documentation/deprecated.txt entry ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
