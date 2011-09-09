Return-Path: util-linux-owner@vger.kernel.org
Received: from gleek.ethostream.com ([66.195.129.15]:53987 "EHLO
	barracuda.ethostream.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759236Ab1IIWZW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 9 Sep 2011 18:25:22 -0400
Date: Sat, 10 Sep 2011 00:07:57 +0200
From: Karel Zak <kzak@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/11] various lscpu changes
Message-ID: <20110909220757.GD4204@nb>
References: <20110906005251.497675140@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110906005251.497675140@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 06, 2011 at 02:52:51AM +0200, Heiko Carstens wrote:
> another set of patches against lscpu. Since you didn't have chance to push
> out your local tree to kernel.org yet, I simply based them on my old lscpu
> branch which you applied on your local tree:

 Merged (available on github) with some minor changes. I have also
 added --online to disable by default enabled --all for -e.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
