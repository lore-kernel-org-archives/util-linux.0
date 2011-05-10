Return-Path: util-linux-owner@vger.kernel.org
Received: from col0-omc2-s16.col0.hotmail.com ([65.55.34.90]:47813 "EHLO
	col0-omc2-s16.col0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751700Ab1EJOwv convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Tue, 10 May 2011 10:52:51 -0400
Message-ID: <COL116-W2730F809BA1D8B601D0B73DA870@phx.gbl>
From: Peter Hallberg <hallberg68@hotmail.com>
To: <util-linux-ng@vger.kernel.org>
Subject: fdisk: creating new partitions problem
Date: Tue, 10 May 2011 16:49:05 +0200
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


When creating a new partition on a disk after an existing partition that ends unaligned there will be a few unused blocks in between them, now when creating yet another partition fdisk will sugest placing the new one in the small room between the existing partitions instead of after the last one.
 		 	   		  