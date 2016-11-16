package org.duniter.elasticsearch.websocket;

/*
    Copyright 2015 ForgeRock AS

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import com.google.common.collect.ImmutableSet;

import java.util.Set;

public class ChangeSource {
    private final Set<String> indices;
    private final Set<String> types;
    private final Set<String> ids;

    public ChangeSource(String source) {
        String[] parts = source.split("/");

        indices = parts[0].equals("*") ? null : ImmutableSet.copyOf(parts[0].split(","));

        if (parts.length > 1) {
            types = parts[1].equals("*") ? null : ImmutableSet.copyOf(parts[1].split(","));
        } else {
            types = null;
        }

        if (parts.length > 2) {
            ids = parts[2].equals("*") ? null : ImmutableSet.copyOf(parts[2].split(","));
        } else {
            ids = null;
        }
    }

    public Set<String> getIds() {
        return ids;
    }

    public Set<String> getIndices() {
        return indices;
    }

    public Set<String> getTypes() {
        return types;
    }

}