Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:58175 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386AbcCNXBH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Mar 2016 19:01:07 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: "George Spelvin" <linux@horizon.com>
Subject: Re: e2fsck: /dev/hda2 is mounted.
Date: Tue, 15 Mar 2016 00:00:51 +0100
Cc: kzak@redhat.com, util-linux@vger.kernel.org
References: <20160313101414.19038.qmail@ns.horizon.com>
In-Reply-To: <20160313101414.19038.qmail@ns.horizon.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201603150000.52094.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sunday 13 March 2016, George Spelvin wrote:

> There were also two batches of complaints about mismatched types in
> printf:
> [...]

These warnings are fixed already in e1a15f8f. They are indicating that 
you are using a 32bit system. Maybe that's important to reproduce the 
bug.

cu,
Rudi
