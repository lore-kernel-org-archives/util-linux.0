Return-Path: util-linux-owner@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:45367 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755282AbbBLN4v (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 12 Feb 2015 08:56:51 -0500
Date: Thu, 12 Feb 2015 14:56:49 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Karel Zak <kzak@redhat.com>
Cc: Felix Miata <mrmazda@earthlink.net>, util-linux@vger.kernel.org
Subject: Re: tty[1-6]: colors a negative accessibility/usability trend
Message-ID: <20150212135649.GD3876@type.bordeaux.inria.fr>
References: <54DC762E.2090404@earthlink.net>
 <20150212132110.GE32318@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20150212132110.GE32318@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak, le Thu 12 Feb 2015 14:21:10 +0100, a écrit :
> For example for fedora I will keep the colors enabled, because it's
> current distribution policy.

But all distributions need to be accessible.  It is a per-user
preference, not a per-task or per-distribution preference.  So upstream
at least needs to provide ways to configure it per user, and downstream
provide a uniform way to configure the various shipped tools.

Samuel
