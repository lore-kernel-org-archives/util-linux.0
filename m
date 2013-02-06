Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56138 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757320Ab3BFLFY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Feb 2013 06:05:24 -0500
Date: Wed, 6 Feb 2013 12:04:40 +0100
From: Karel Zak <kzak@redhat.com>
To: Cristian =?iso-8859-1?Q?Rodr=EDguez?= <crrodriguez@opensuse.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Test for secure_getenv too.
Message-ID: <20130206110440.GF24476@x2.net.home>
References: <1360040883-29778-1-git-send-email-crrodriguez@opensuse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1360040883-29778-1-git-send-email-crrodriguez@opensuse.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 05, 2013 at 02:08:03AM -0300, Cristian Rodríguez wrote:
> In current glibc versions, internal __secure_getenv
> no longer exists and was replaced by secure_getenv()

 Good catch, applied. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
