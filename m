Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:16079 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094Ab2G0Kbf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Jul 2012 06:31:35 -0400
Date: Fri, 27 Jul 2012 12:31:32 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux@vger.kernel.org
Subject: Re: v2.22-rc2 wish list
Message-ID: <20120727103132.GA28708@x2.net.home>
References: <20120727081033.GA14019@x2.net.home>
 <CAG27Bk1mk08N=0Zbo-Bbd_v93C6cfEcO1chYyiDAtRf1sQOEpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk1mk08N=0Zbo-Bbd_v93C6cfEcO1chYyiDAtRf1sQOEpw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 27, 2012 at 10:26:24AM +0200, Sami Kerola wrote:
> I think it might be good idea to try to get 'make check' to run
> './tests/run.sh'.

 Maybe, but many of the tests requires root permissions and it's
 designed for developers only. I'd like to avoid situations when the
 tests are executed with root permissions by automatic distro build
 systems etc.

 Maybe we can improve run.sh to be require .git/ in the top level
 sources directory if executed with root permissions.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
