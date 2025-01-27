# vim:set ft=dockerfile:
#
# Copyright The CloudNativePG Contributors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
FROM postgres:17.2-bookworm

# Do not split the description, otherwise we will see a blank space in the labels
LABEL name="PostgreSQL Container Images" \
      vendor="The CloudNativePG Contributors" \
      version="${PG_VERSION}" \
      release="36" \
      summary="PostgreSQL Container images." \
      description="This Docker image contains PostgreSQL and Barman Cloud based on Postgres 17.2-bookworm."

LABEL org.opencontainers.image.description="This Docker image contains PostgreSQL and Barman Cloud based on Postgres 17.2-bookworm."

COPY requirements.txt /

# Install additional extensions
ENV PGROONGA_VERSION=3.2.5-1
RUN set -xe && \
	apt-get update && \
	apt-get install -y --no-install-recommends \
		"postgresql-${PG_MAJOR}-pgaudit" \
		"postgresql-${PG_MAJOR}-pgvector" \
		"postgresql-${PG_MAJOR}-pg-failover-slots" \
	&& apt install -y -V curl lsb-release && \
	curl -LO https://apache.jfrog.io/artifactory/arrow/debian/apache-arrow-apt-source-latest-$(lsb_release --codename --short).deb && \
	apt-get install -y -V ./apache-arrow-apt-source-latest-$(lsb_release --codename --short).deb && \
	rm apache-arrow-apt-source-latest-$(lsb_release --codename --short).deb && \
	curl -LO https://packages.groonga.org/debian/groonga-apt-source-latest-$(lsb_release --codename --short).deb && \
	apt-get install -y -V ./groonga-apt-source-latest-$(lsb_release --codename --short).deb && \
	rm groonga-apt-source-latest-$(lsb_release --codename --short).deb && \
	apt-get update && \
		apt install -y -V \
		postgresql-${PG_MAJOR}-pgdg-pgroonga=${PGROONGA_VERSION} \
		groonga-normalizer-mysql \
		groonga-token-filter-stem \
		groonga-tokenizer-mecab && \
	rm -fr /tmp/*  && \
	rm -rf /var/lib/apt/lists/*

# Install barman-cloud
RUN set -xe; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		python3-pip \
		python3-psycopg2 \
		python3-setuptools \
	; \
	pip3 install --break-system-packages --upgrade pip; \
	# TODO: Remove --no-deps once https://github.com/pypa/pip/issues/9644 is solved
	pip3 install --break-system-packages --no-deps -r requirements.txt; \
	rm -rf /var/lib/apt/lists/*;

# Change the uid of postgres to 26
RUN usermod -u 26 postgres
USER 26
