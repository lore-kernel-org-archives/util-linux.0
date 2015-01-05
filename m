Return-Path: util-linux-owner@vger.kernel.org
Received: from ec2-54-241-211-23.us-west-1.compute.amazonaws.com ([54.241.211.23]:46304
	"EHLO feystorm.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753066AbbAEWcr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Jan 2015 17:32:47 -0500
Received: from [10.230.134.34] (ec2-107-23-93-221.compute-1.amazonaws.com [107.23.93.221])
	(using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by feystorm.net (Postfix) with ESMTPSA id 8A22A191CE7B
	for <util-linux@vger.kernel.org>; Mon,  5 Jan 2015 17:32:45 -0500 (EST)
Message-ID: <54AB110A.90604@feystorm.net>
Date: Mon, 05 Jan 2015 17:32:42 -0500
From: Patrick Hemmer <kernel@feystorm.net>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: statically linked nsenter
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is just a simple request for the configure script to support
statically linking the nsenter utility.
Several other utilities are supported, but not nsenter, which I would
argue is probably the most important tool to support static linking as
it can be used to work with namespaces where the libraries it needs are
not be available.

Thanks

-Patrick
