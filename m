Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33788 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135AbcAORsb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 15 Jan 2016 12:48:31 -0500
Date: Fri, 15 Jan 2016 18:48:29 +0100
From: Karel Zak <kzak@redhat.com>
To: Hua Zhong <hzhong@gmail.com>
Cc: richard@nod.at, util-linux@vger.kernel.org
Subject: Re: Bad interaction between in.telnetd and login
Message-ID: <20160115174829.5yayeuk57ksgms4q@ws.net.home>
References: <CAHL05WNh=Tr_c91hpK462bfziiE+MK7zkrRLJ3u-BSvcmQTcig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHL05WNh=Tr_c91hpK462bfziiE+MK7zkrRLJ3u-BSvcmQTcig@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 14, 2016 at 03:26:45PM -0800, Hua Zhong wrote:
> While working on Fedora 18, we found that sometimes telnetd would close
> connections unexpectedly:

Sounds like: 
https://bugzilla.redhat.com/show_bug.cgi?id=962145

maybe it's time to update... try util-linux >= 2.24, the current
upstream stable version is v2.27.1.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
