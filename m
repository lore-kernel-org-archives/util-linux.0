Return-Path: util-linux-owner@vger.kernel.org
Received: from sender1.zohomail.com ([72.5.230.95]:16975 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab3BBXAG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 2 Feb 2013 18:00:06 -0500
Message-ID: <510D99FD.8060608@zoho.com>
Date: Sat, 02 Feb 2013 23:58:05 +0100
From: =?ISO-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>
MIME-Version: 1.0
To: Sami Kerola <kerolasa@iki.fi>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] a pointer should not be compared to zero [coccinelle]
References: <1359578005-13427-1-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1359578005-13427-1-git-send-email-kerolasa@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 30/01/13 21:33, Sami Kerola wrote "a pointer should not be compared
to zero":
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>

Why not? It is perfectly legal.
See http://www.c-faq.com/null/null2.html

> ---
> -	if (mnt == 0) {
> +	if (mnt == NULL) {

> -	while ((dp = readdir(dir)) != 0) {
> +	while ((dp = readdir(dir)) != NULL) {

> -	if (Sflag == 0)
> +	if (Sflag == NULL)

> -	if (Bflag == 0) {
> +	if (Bflag == NULL) {

> -	if (Mflag == 0)
> +	if (Mflag == NULL)

> -  if (types == 0) {
> +  if (types == NULL) {

> -				get_logname(&options, &termios, &chardata)) == 0)
> +				get_logname(&options, &termios, &chardata)) == NULL)

> -	for (cp = strtok(arg, ","); cp != 0; cp = strtok((char *)0, ",")) {
> +	for (cp = strtok(arg, ","); cp != NULL; cp = strtok((char *)0, ",")) {

> -		if ((term = getenv("TERM")) == 0) {
> +		if ((term = getenv("TERM")) == NULL) {

> -			if (Home == 0 || *Home == '\0') {
> +			if (Home == NULL || *Home == '\0') {

