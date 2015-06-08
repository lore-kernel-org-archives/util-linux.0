Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60513 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992AbbFHKVp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 8 Jun 2015 06:21:45 -0400
Date: Mon, 8 Jun 2015 12:21:43 +0200
From: Karel Zak <kzak@redhat.com>
To: Guillem Jover <guillem@hadrons.org>
Cc: util-linux@vger.kernel.org, Steven Chamberlain <steven@pyro.eu.org>
Subject: Re: [PATCH 0/3] Handle lack of F_DUPFD_CLOEXEC support
Message-ID: <20150608102143.GC1992@ws.net.home>
References: <1433564347-9515-1-git-send-email-guillem@hadrons.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433564347-9515-1-git-send-email-guillem@hadrons.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> Guillem Jover (3):
>   lib/fileutils: Add new dup_fd_cloexec function
>   lib/sysfs: Use dup_fd_cloexec instead of direct call to fcntl
>   include/c: Define F_DUPFD_CLOEXEC on kFreeBSD systems if missing

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
