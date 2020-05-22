Return-Path: <SRS0=7FR5=7E=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFB8C433DF
	for <util-linux@archiver.kernel.org>; Fri, 22 May 2020 06:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06DC22072C
	for <util-linux@archiver.kernel.org>; Fri, 22 May 2020 06:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="XTCTeoX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgEVGZB (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 22 May 2020 02:25:01 -0400
Received: from mout.web.de ([217.72.192.78]:59717 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgEVGZB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 22 May 2020 02:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590128699;
        bh=+1ZTKArgDeV1JzdWo6uNtsye0UXNuE7nxqfwwg9LELs=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=XTCTeoX45XP/ATptuphH6XuOKPcjeCd4DvkvPa3CRuZ+qGvVXwqSFZNF6fi7vL61N
         cvLGsqfdXGocs9IXwgJsRXK/pcStdJpHh413ygH2bnEZEwfiAPbakfsOCBvIHlMyek
         rI12g6bsy4xN6VC7uiHcwXY4bGXcmvZ/3DVZzcEY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.0.94] ([37.201.146.115]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2Mcy-1ikC6h3Em4-00s8mX for
 <util-linux@vger.kernel.org>; Fri, 22 May 2020 08:24:59 +0200
To:     util-linux@vger.kernel.org
From:   andy <online-a-n@web.de>
Subject: Thank you for util-linux.
Message-ID: <4efd7f26-db61-f09d-88ef-cd5adb4f03ed@web.de>
Date:   Fri, 22 May 2020 08:24:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:cLkzTmVp51Tr/Gqms8FlJPZRfvObWUQV6cUq4gcar1tATqvgLWB
 /ImZk6ezotrRG2kwPyg438CferT6NBw2mvcxEO91MYsFwX2ghSnepGesrKazZ0AKh1FrXaA
 6PY+jFO0N5S07RcSmshUMyclEptD5br1tYIu+HyuNepzLv1jf42+owr1wLrSC7aPoSdX6f8
 SuMtZ1HtxmQVJnGpef2xw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V68IlKwj+Iw=:wlbJPJyWPbBhDKSNIhN32g
 nVnMRp2zBoybg8uk3iMoqeR3foQ0wNG3z4ZQru6tjMWjlnGRL/iK1KqWYbhjGGV15JPcB+G5o
 KEoZzAizkRWl3NM5VuGhCcNByzI7bIdXcz2jkWiYL/hQM4v2U5Nmbnrvupi1lBelsbGIhZNVx
 VG9q6kou4wkrKr2FjG+Swwj8vxSv3pPE5qsN1lkJty6pzEFKS9JACjp3L1zGCj8BW4752yTMo
 MlFQ2A3lEhuxlM0tPbtaD1MTKT1hx3RwOO7m/RMvYfYUIBH9j+UPBq/meusG8oLr54982DHJ9
 GVH/TUTYg5tAxlL+jq2Y0wh7IsscfcFzjR1r5MqaRHXEZTgI4ugNffHPzT4WgDK6v9/z1tYOp
 m3F2R1g/h1ZAPSlx/fKVeZ6OLDv8QWYWTnOzcmH/UDE4M9Td9EhAWGGm1LrIImI324w17x+++
 Yvqlquk2YnDatM4gxVw/3ex3O0PeVeEj3GGO8CRK0PQwZFP6jfxp6Os9ssnqj7yfgK9RPJbc3
 6jeNk3cXjqwX1hFUzBLW6YkcbEQiE/nPhLUjFnFuSiFZ96V8uNGtTI8N7/OBf4uvan08pINxN
 91i4o9D1CQ74Yl8GOZ2t9UvFK+3Wg+wqg8G5sO730eU6p0i2rlvcrb36O+dHBOQy6GTkHLCtR
 Y3SVEveaF91CrzGSgqzgU0WCEPj6aTf05HUC8W7KQcSsJ1YY5GPi5HwrD5+0zUiIkSjbN/6+f
 vxSfd/tQW2L6OcwctsCtDzmGnyzy3nJ70QD6dq4BJfyXu0Sy3ojOeTsuRIrgkxjFg0jWppnmv
 3RWMxUBJl96pw2Na++Gz3U+KOB7VY3QnXPXmGtVCCI/Z0LTv45ZWDaU/Nzq9hxhue3W/Vfibl
 u8a9qBNPhNKv/egXaU4QFTPj5z5ltTptDLF5TvK20/kAOM2nKAVa8Ic5P1ruHfTnj14XqP41J
 3OMtiYKdld/Or0jHZPsRb6NcDXyFjv9+NVjpYgTF9CLcICImpTpDqxYvCpqUcthY0aJpF35pT
 sKvlEE5RPzA7nGl8oP+e4JMXeiKuEpSI/XNs8mn06RR4HX/Ns39GjfljLfyv4sMVLVfNQc3BJ
 jYyYkYyr3ryaXjxlnUcKOA6kDTyXZ0fiUMbNakFG/0TYyy97dUzr4FdxTenfwADZ3pDRYyiEA
 fCJysMspIG/F7Tv7jOjYoi8gC3htICts4NlZ7nw52dijOuy1GtrIQvNZoQvwGOlUcWXxQsQGH
 4sAAydYRdOeC7ro53
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Thank you for util-linux.

