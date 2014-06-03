Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:64097 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753665AbaFCNJ1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 3 Jun 2014 09:09:27 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0M5Z5A-1WcDWv2Jdg-00xZ8g for
 <util-linux@vger.kernel.org>; Tue, 03 Jun 2014 15:09:25 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: build-sys: minor issues
Date: Tue, 3 Jun 2014 15:09:24 +0200
References: <201406020056.17074.sweet_f_a@gmx.de>
In-Reply-To: <201406020056.17074.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201406031509.24914.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 02 June 2014, Ruediger Meier wrote:
> I have two minor issues with our build-sys:

Another issue:

4. --disable-all-programs disables pylibmount forever

--with-python   does not turn it on again
--enable-pylibmount  does not exist

or do I miss something?
