Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1513 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249Ab2G0U17 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Jul 2012 16:27:59 -0400
Date: Fri, 27 Jul 2012 22:27:52 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>, kerolasa@gmail.com,
        util-linux@vger.kernel.org
Subject: Re: v2.22-rc2 wish list
Message-ID: <20120727202752.GC29738@x2.net.home>
References: <20120727081033.GA14019@x2.net.home>
 <CAG27Bk1mk08N=0Zbo-Bbd_v93C6cfEcO1chYyiDAtRf1sQOEpw@mail.gmail.com>
 <20120727103132.GA28708@x2.net.home>
 <501271D2.8090708@bernhard-voelker.de>
 <20120727111550.GA29738@x2.net.home>
 <50127F34.70406@bernhard-voelker.de>
 <1343394804.2752.5.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343394804.2752.5.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 27, 2012 at 03:13:24PM +0200, Davidlohr Bueso wrote:
> > With a proper test suite, we give him/her a basic test to check whether
> > the software is running as expected in his/her environment. Otherwise,
> > he doesn't have much chance other than waiting for productive problems.
> > 
> I partially agree with this. However our test scripts are strictly
> regression testing and, of course, that is part of the development
> cycle, so end-users have no business dealing with this. For example, we
> cannot ask users to rebuild their kernel just to run theses tests (like
> scsi_debug module).

 Exactly, reports from end users like "test XY failed" are completely
 useless if the user is not able to debug the problem.

 Anyway, more tests, and the tests improvements are wanted.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
