Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55385 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754990Ab2F0Jac (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 27 Jun 2012 05:30:32 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q5R9UWsb001938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Wed, 27 Jun 2012 05:30:32 -0400
Received: from x2 (ovpn-113-129.phx2.redhat.com [10.3.113.129])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q5R9UVvh001276
	for <util-linux@vger.kernel.org>; Wed, 27 Jun 2012 05:30:32 -0400
Date: Wed, 27 Jun 2012 11:30:30 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux <util-linux@vger.kernel.org>
Subject: Re: non-recursive build system
Message-ID: <20120627093030.GA21972@x2.net.home>
References: <20120612100340.GB23991@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20120612100340.GB23991@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 12, 2012 at 12:03:40PM +0200, Karel Zak wrote:
> 
> 
>  The original version was implemented by Diego Elio 'Flameeyes' Pettenò
>  two years ago:
>      http://thread.gmane.org/gmane.linux.utilities.util-linux-ng/3297
> 
>  See also:
>      http://www.flameeyes.eu/autotools-mythbuster/automake/nonrecursive.html
> 
>  My current version is available at github, 'non-recursive' branch:
>      https://github.com/karelzak/util-linux/commits/non-recursive
> 

 Merged into master branch, "git clean -xdf" after git pull is your
 good friend. Good luck ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
