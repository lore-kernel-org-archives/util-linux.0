Return-Path: util-linux-owner@vger.kernel.org
Received: from gimli.pitney-fabs.co.uk ([87.106.140.52]:47319 "EHLO
	gimli.pitney-fabs.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512Ab1LIMuY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 9 Dec 2011 07:50:24 -0500
Received: from host81-139-106-247.in-addr.btopenworld.com ([81.139.106.247] helo=golden.localdomain)
	by gimli.pitney-fabs.co.uk with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <walrond.andrew@gimli.pitney-fabs.co.uk>)
	id 1RYzuB-0001EF-4Q
	for util-linux@vger.kernel.org; Fri, 09 Dec 2011 12:50:23 +0000
Date: Fri, 9 Dec 2011 12:50:21 +0000
From: Andrew Walrond <andrew@walrond.org>
To: util-linux@vger.kernel.org
Subject: Re: Mount -a and bind mounts. Bug?
Message-ID: <20111209125021.GB3173@golden.localdomain>
References: <20111209123357.GA3173@golden.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111209123357.GA3173@golden.localdomain>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In case it's relevant - /etc/mtab is a symlink to /proc/mounts.
