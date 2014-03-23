Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.24]:51619 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbaCWJGu (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 23 Mar 2014 05:06:50 -0400
Date: Sun, 23 Mar 2014 10:06:33 +0100
From: Werner Baumann <werner.baumann@onlinehome.de>
To: util-linux@vger.kernel.org
Subject: libmount, documentation
Message-ID: <20140323100633.711b61f9@ginster.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I would like to use libmount in my mounthelper program (davfs2) to
solve issues that arise when /etc/mtab is a symbolic link
to /proc/mounts.

But I can't find any documentation of libmount that would allow me to
use it. Is there any documentation?

Werner
