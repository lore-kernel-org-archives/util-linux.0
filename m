Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58335 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293Ab1FXSZm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 24 Jun 2011 14:25:42 -0400
Received: by gwaa18 with SMTP id a18so1187538gwa.19
        for <util-linux@vger.kernel.org>; Fri, 24 Jun 2011 11:25:41 -0700 (PDT)
Message-ID: <4E04D6A3.4060105@gmail.com>
Date: Fri, 24 Jun 2011 13:25:39 -0500
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: fdisk
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In fdisk, printing a partition table gives the headers:

Device Boot      Start         End      Blocks   Id  System

What's a block?  It does not seem to be defined anywhere.  Perhaps an 
update to the man page would be appropriate.  A line in the explanation 
above the partition listing would be even better.

On my system, a block appears to be 2-512 byte sectors, but is it always so?

   -- Bruce
